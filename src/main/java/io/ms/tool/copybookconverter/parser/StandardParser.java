package io.ms.tool.copybookconverter.parser;

import io.ms.tool.copybookconverter.parser.model.GroupField;
import io.ms.tool.copybookconverter.parser.model.PicField;
import io.ms.tool.copybookconverter.parser.model.RawField;
import io.ms.tool.copybookconverter.reader.CopybookReader;
import io.ms.tool.copybookconverter.util.CobolKeyword;
import io.ms.tool.copybookconverter.util.CobolUtils;
import io.ms.tool.copybookconverter.util.ParsingUtils;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Standard copybook parser
 * @author m.scurti
 */
@Component
public class StandardParser implements CopybookParser {
    //USER VARIABLES
    ParserStats stats;

    //KNOWN VALUES
    private static final int MINIMUM_TOKEN_NUMBER = 2; //to be a valid candidate to become a field
    private static final String SPLIT_CHARACTER = ","; //used to split the line into tokens

    @Override
    public List<RawField> parse(CopybookReader reader) throws IOException {
        stats = new ParserStats(); //reset stats
        CopybookLevelsHandler levelsHandler = new CopybookLevelsHandler();

        String line;
        while ((line = reader.readNext()) != null) {
            String[] tokens = preprocess(line); //preprocessing

            RawField rawField = matchPattern(line, tokens); //information extraction

            if (rawField != null) {
                levelsHandler.addField(rawField); //hierarchy preservation
            }
        }

        reader.close();

        return levelsHandler.getParsedFields();
    }

    @Override
    public ParserStats inspectParser() {
        return stats;
    }

    private String[] preprocess(String line) {
        String proc0 = line.trim();

        if (proc0.isEmpty()) {
            return null;
        }

        if (CobolUtils.isLineCommented(proc0)) {
            stats.insertDiscardedLine(line);
            return null;
        }

        stats.newDetectedFields(); //increment internal counter

        String proc1 = proc0.replaceAll("\\s+", SPLIT_CHARACTER); //replace all white spaces with a single comma
        String[] tokens = proc1.split(SPLIT_CHARACTER); //split line into tokens

        if (tokens.length < MINIMUM_TOKEN_NUMBER) { //cobol fields are defined by at least 3 tokens, e.g. 05 NAME PIC X(3)
            stats.insertDiscardedLine(line);
            return null;
        }

        return tokens;
    }

    /**
     * Recognizes the pattern inside a line of the copybook
     * FORMATS:
     * CASE 1: [level] [field name] PIC [type].                                                        --supported
     * CASE 2: [level] FILLER PIC X([num]).                                                            --supported
     * CASE 3: [level] [field name].                                                                   --supported
     * CASE 4: [level] [field name] OCCURS [number of reps].                                           --supported
     * CASE 5: [level] [field name] OCCURS [number of reps] PIC [type].                                --supported
     * CASE 6: [level] [field name] PIC [type] VALUE [init value].                                     --supported
     * CASE 7: [level] [field name] OCCURS [number of reps] PIC [type] VALUE [init value].             --supported
     * CASE 8: [level] [field name] OCCURS [number of reps] PIC [type] VALUE ZEROES.                   --
     * CASE 9: [level] [field name] OCCURS [number of reps] PIC [type] VALUE SPACES.                   --
     * CASE10: [level] [field name] OCCURS [min number] TO [max number] DEPENDING ON [field name ref]. --
     *
     * minimum number of tokens to be a valid candidate: 2
     * @param tokens - the input line splitted into tokens
     */
    private RawField matchPattern(String originalLine, String[] tokens) {
        if (tokens == null) return null;

        RawField field;

        //search for the language-specific keywords "PIC" or "OCCURS"
        int picPos = ParsingUtils.searchFirstOccurrence(tokens, CobolKeyword.PIC.name());
        int occursPos = ParsingUtils.searchFirstOccurrence(tokens, CobolKeyword.OCCURS.name());

        if (picPos != ParsingUtils.NOT_FOUND && occursPos != ParsingUtils.NOT_FOUND) {
            //CASE 5
            field = composeGroupListField(tokens, picPos, occursPos);
        } else if (picPos != ParsingUtils.NOT_FOUND) {
            //CASE 1 OR 2
            field = composePictureField(tokens, picPos);
        } else if (occursPos != ParsingUtils.NOT_FOUND) {
            //CASE 4
            field = composeListField(tokens, occursPos);
        } else {
            //CASE 3 or other not mentioned cases
            field = composeGroupField(tokens);
        }

        if (field == null) {
            stats.insertDiscardedLine(originalLine);
            return null;
        }

        field.setOriginalLine(originalLine);

        return field;
    }

    /**
     * Parsing method for text lines containing a PICTURE definition
     * Cases ID: 1, 2
     * @param tokens - text line splitted into tokens
     * @param indexOfPic - index of the PIC keyword inside the tokens vector
     * @return a structured representation of the text line
     */
    private PicField composePictureField(String[] tokens, int indexOfPic) {
        Integer level = Integer.parseInt(tokens[indexOfPic - 2]); //retrieves the [level] token
        String fieldName = tokens[indexOfPic - 1].replaceAll("[:-]", "").toLowerCase(); //[field name] token
        String typeDefinition = reconstructTypeField(tokens, indexOfPic); //[type] of the field
        List<String> params = parseFieldParams(typeDefinition); //parses the parameters of the picture field
        String typeDefinitionPattern = extractPattern(typeDefinition); //gets the standardized format of the typeDefinition

        boolean isFiller = CobolUtils.isFiller(fieldName);
        if (isFiller) {
            stats.newFillerField();
        }

        return new PicField(null, level, fieldName, null, typeDefinitionPattern, params, getDefaultValue(tokens),isFiller);
    }

    /**
     * Parsing method for text lines containing an OCCURS definition
     * Cases ID: 4
     * @param tokens - text line splitted into tokens
     * @param indexOfOccurs - index of the PIC keyword inside the tokens vector
     * @return a structured representation of the text line
     */
    private GroupField composeListField(String[] tokens, int indexOfOccurs) {
        Integer level = Integer.parseInt(tokens[indexOfOccurs - 2]);
        String fieldName = tokens[indexOfOccurs - 1].replaceAll("[:-]", "").toLowerCase();
        Integer repetitions = Integer.parseInt(tokens[indexOfOccurs + 1].replaceAll("\\.", ""));

        return new GroupField(null, level, fieldName, null, repetitions);
    }

    /**
     * Parsing method for text lines containing an OCCURS and PICTURE definition
     * Cases ID: 5
     * @param tokens - text line splitted into tokens
     * @param indexOfOccurs - index of the PIC keyword inside the tokens vector
     * @return a structured representation of the text line
     */
    private GroupField composeGroupListField(String[] tokens, int indexOfPic, int indexOfOccurs) {
        Integer level = Integer.parseInt(tokens[indexOfOccurs - 2]);
        String fieldName = tokens[indexOfOccurs - 1].replaceAll("[:-]", "").toLowerCase();
        Integer repetitions = Integer.parseInt(tokens[indexOfOccurs + 1].replaceAll("\\.", ""));

        String typeDefinition = reconstructTypeField(tokens, indexOfPic);
        List<String> params = parseFieldParams(typeDefinition);
        String typeDefinitionPattern = extractPattern(typeDefinition);

        boolean isFiller = CobolUtils.isFiller(fieldName);

        GroupField group = new GroupField(null, level, fieldName, null, repetitions);
        group.insertSubfield(new PicField(null, level, fieldName, null, typeDefinitionPattern, params, getDefaultValue(tokens), isFiller));

        return group;
    }

    /**
     * Parsing method for text lines containing NO PIC and NO OCCURS definition
     * Cases ID: 3
     * @param tokens - text line splitted into tokens
     * @return a structured representation of the text line
     */
    private GroupField composeGroupField(String[] tokens) {
        int vectorLength = tokens.length;
        String fieldNameToken = tokens[tokens.length - 1];

        if (!fieldNameToken.matches("[0-9a-zA-Z\\-]*") && fieldNameToken.charAt(fieldNameToken.length() - 1) != '.') {
            return null;
        }

        Integer level = Integer.parseInt(tokens[vectorLength - 2]);
        String fieldName = fieldNameToken.substring(0, fieldNameToken.length() - 1).replaceAll("[:-]", "").toLowerCase();

        return new GroupField(null, level, fieldName, null);
    }

    /**
     *
     * @param tokens
     * @param indexOfPic
     * @return
     */
    private String reconstructTypeField(String[] tokens, int indexOfPic) {
        StringBuilder typeBuilder = new StringBuilder();

        //join remaining tokens which define the type of the field
        for (int i = indexOfPic + 1; i < tokens.length && !tokens[i].equals(CobolKeyword.VALUE.name()); i++) {
            typeBuilder.append(tokens[i]);
            typeBuilder.append(" ");
        }

        String _reconstructedType = typeBuilder.toString().trim();
        String reconstructedType = _reconstructedType.replace(".", ""); //removes the dot
        if (!reconstructedType.contains("(")) {
            int fieldLength = reconstructedType.length();
            String standardizedPattern = reconstructedType.replaceAll("(?i)([0-9])\\1{2,}", "$1"); //handling -99999.99999 types
            return standardizedPattern + String.format("(%d)", fieldLength);
        }

        return reconstructedType;
    }

    /**
     * Takes all numbers between parenthesis. these numbers inside parenthesis represents parameters of the field
     * @param type - the string containing the type definition
     * @return list of parameters extracted
     */
    private List<String> parseFieldParams(String type) {
        Matcher m = Pattern.compile("\\(([^)]+)\\)").matcher(type);
        List<String> params = new ArrayList<>();
        while(m.find()) {
            params.add(m.group(1));
        }

        return params;
    }

    /**
     * Replaces every number between parenthesis in order to recognize the field type in a standard format
     * @param type - type of the field token, extracted from text
     * @return standardized type
     */
    private String extractPattern(String type) {
        return type.replaceAll("(?<=\\().*?(?=\\))", "%");
    }


    /**
     * Extracts the default value for the field
     * pattern: VALUE [default value].
     * @param tokens the original line being processed
     * @return extracted default value for the field
     */
    private String getDefaultValue(String[] tokens) {
        int valuePos = ParsingUtils.searchFirstOccurrence(tokens, CobolKeyword.VALUE.name());

        if (valuePos == ParsingUtils.NOT_FOUND) {
            return null;
        }

        String _valueToken = tokens[valuePos + 1];
        String processedToken = _valueToken.replaceAll("'", "").replaceAll("\"", "");
        return processedToken.substring(0, processedToken.length() - 1); //removes the dot
    }

}
