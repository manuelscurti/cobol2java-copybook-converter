package io.ms.tool.parser;

import io.ms.tool.util.CobolUtils;
import io.ms.tool.util.StringUtils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Standard copybook parser
 * It does not provide any extra functionality such as: smart variable naming
 *
 *
 *
 */
public class StandardParser implements CopybookParser {
    //USER VARIABLES
    ParserStats stats;

    //KNOWN VALUES
    private static final int MINIMUM_TOKEN_NUMBER = 2; //to be a valid candidate to become a field

    //CORE FUNCTIONALITIES
    RawField2 lastParsedField;
    Stack<List<RawField2>> fieldsStack;

    @Override
    public List<RawField> parse(String filepath) throws IOException {
        stats = new ParserStats(); //reset stats
        lastParsedField = null;
        fieldsStack = new Stack<>();

        BufferedReader reader = new BufferedReader(new FileReader(filepath));

        String line;
        List<RawField2> rawFields = new ArrayList<>();
        fieldsStack.push(rawFields);

        while ((line = reader.readLine()) != null) {
            RawField2 rawField = preprocess(line);
            if (rawField != null && lastParsedField != null) {
                if ((lastParsedField instanceof GroupField) && rawField.getLevel() > lastParsedField.getLevel()) {
                    //going deep
                    ((GroupField) lastParsedField).insertSubfield(rawField);
                    fieldsStack.push(((GroupField) lastParsedField).getSubfields());
                } else if (rawField.getLevel() < lastParsedField.getLevel()) {
                    //going up
                    List<RawField2> currentFieldList = fieldsStack.pop(); //removes current level
                    while (rawField.getLevel() < currentFieldList.get(0).getLevel()) {
                        currentFieldList = fieldsStack.pop();
                    }
                    currentFieldList.add(rawField);
                    fieldsStack.push(currentFieldList);
                } else {
                    List<RawField2> currentFieldList = fieldsStack.pop();
                    currentFieldList.add(rawField);
                    fieldsStack.push(currentFieldList);
                }
            } else if (lastParsedField == null) {
                List<RawField2> currentFieldList = fieldsStack.pop();
                currentFieldList.add(rawField);
                fieldsStack.push(currentFieldList);
            }
            this.lastParsedField = rawField;
        }

//        debugRawFields(rawFields);
        System.out.println("FIELDS DETECTED: "+stats.getTotalDetectedFields());
        System.out.println("DISCARDED LINES: ");
        System.out.println(stats.getDiscardedLines());

        reader.close();

//        return rawFields;
        return null;
    }

    @Override
    public ParserStats inspectParser() {
        return stats;
    }

    private RawField2 preprocess(String line) {
        String proc0 = line.trim();

        //FIXME: to be hierarchy preserving, this control here has to be deprecated
//        if (!CobolUtils.containsFieldSpecs(proc0)) {
//            stats.insertDiscardedLine(line);
//            return null;
//        }

        if (CobolUtils.isLineCommented(proc0)) {
            stats.insertDiscardedLine(line);
            return null;
        }

        stats.newDetectedFields(); //increment internal counter

//        String proc1 = proc0.substring(0, proc0.lastIndexOf("."));
        String proc2 = proc0.replaceAll("\\s+", ","); //replace all white spaces with a single comma
        String[] tokens = proc2.split(","); //split line into tokens

        if (tokens.length < MINIMUM_TOKEN_NUMBER) { //cobol fields are defined by at least 3 tokens, e.g. 05 NAME PIC X(3)
            stats.insertDiscardedLine(line);
            return null;
        }

//        if (!CobolUtils.containsFieldSpecs(proc0)) {
//            if (tokens.length == MINIMUM_TOKEN_NUMBER) {
//
//            } else {
//                stats.insertDiscardedLine(line);
//                return null;
//            }
//        }

//        int indexOfPic = 0;
//        for (; indexOfPic < tokens.length && !tokens[indexOfPic].equals("PIC"); indexOfPic++) {
//        }
//
//        if (indexOfPic - 2 < 0) {
//            stats.insertDiscardedLine(line);
//            return null;
//        }

//        Integer level = Integer.parseInt(tokens[indexOfPic - 2]);
//        String fieldName = tokens[indexOfPic - 1].replaceAll("[:-]", "").toLowerCase();
//        String typeDefinition = reconstructTypeField(tokens, indexOfPic);
//        List<String> params = parseFieldParams(typeDefinition);
//        String typeDefinitionPattern = extractPattern(typeDefinition);
//        boolean isFiller = CobolUtils.isFiller(fieldName);
//        if (isFiller) {
//            stats.newFillerField();
//        }
//
//        return new RawField(level, fieldName, typeDefinitionPattern, params, isFiller);
        RawField2 rawField = patternMatcher(proc2, ",");


        return rawField;
    }

    /**
     *  * formats:
     *  CASE 1* [level] [field name] PIC [type].              --supported
     *  CASE 2* [level] FILLER PIC X([num]).                  --supported
     *  CASE 3* [level] [field name].                         --supported
     *  CASE 4* [level] [field name] OCCURS [number of reps]. --supported
     *  *
     *  * minimum number of tokens to be a valid candidate: 2
     * @param line
     * @param separator
     */
    private RawField2 patternMatcher(String line, String separator) {
        RawField2 field = null;
        String[] tokens = line.split(separator);

        //search for the language-specific keyword "PIC" or "OCCURS"
        int langPos;
        if ((langPos = StringUtils.searchFirstOccurrence(tokens, "PIC")) != StringUtils.NOT_FOUND) {
            //CASE 1 OR 2
            field = composePictureField(tokens, langPos);
        } else if ((langPos = StringUtils.searchFirstOccurrence(tokens, "OCCURS")) != StringUtils.NOT_FOUND) {
            //CASE 4
            field = composeListField(tokens, langPos);
        } else {
            //CASE 3 or other not mentioned cases
            field = composeGroupField(tokens);
        }

        if (field == null) {
            stats.insertDiscardedLine(line);
            return null;
        }

        field.setOriginalLine(line);

        return field;
    }

    private PicField composePictureField(String[] tokens, int indexOfPic) {
        Integer level = Integer.parseInt(tokens[indexOfPic - 2]);
        String fieldName = tokens[indexOfPic - 1].replaceAll("[:-]", "").toLowerCase();
        String typeDefinition = reconstructTypeField(tokens, indexOfPic);
        List<String> params = parseFieldParams(typeDefinition);
        String typeDefinitionPattern = extractPattern(typeDefinition);
        boolean isFiller = CobolUtils.isFiller(fieldName);
        if (isFiller) {
            stats.newFillerField();
        }

        return new PicField(null, level, fieldName, null, typeDefinitionPattern, params, isFiller);
    }

    private GroupField composeListField(String[] tokens, int indexOfOccurs) {
        Integer level = Integer.parseInt(tokens[indexOfOccurs - 2]);
        String fieldName = tokens[indexOfOccurs - 1].replaceAll("[:-]", "").toLowerCase();
        Integer repetitions = Integer.parseInt(tokens[indexOfOccurs + 1].replaceAll("\\.", ""));

        return new GroupField(null, level, fieldName, null, repetitions);
    }

    /**
     * This method assumes that a group field has a name composed only by:
     * numbers,letters and eventually "-", ending the whole name with a single dot.
     * @param tokens
     * @return
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

    private String reconstructTypeField(String[] tokens, int indexOfPic) {
        StringBuilder typeBuilder = new StringBuilder();

        //join remaining tokens which define the type of the field
        for (int i = indexOfPic + 1; i < tokens.length; i++) {
            typeBuilder.append(tokens[i]);
            typeBuilder.append(" ");
        }

        String _reconstructedType = typeBuilder.toString().trim();
        String reconstructedType = _reconstructedType.substring(0, _reconstructedType.length() - 1); //removes the dot
        if (!reconstructedType.contains("(")) {
            int fieldLength = reconstructedType.length();
            String standardizedPattern = reconstructedType.replaceAll("(?i)([0-9])\\1{2,}", "$1"); //handling -99999.99999 types
            return standardizedPattern + String.format("(%d)", fieldLength);
        }

        return reconstructedType;
    }

    /**
     * S9(X)V9(Y)
     * @param type
     * @return
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
     * Replaces every number between parenthesis in order to save the field type in a standard form
     * @param type - type of the field token, extracted from text
     * @return standardized type
     */
    private String extractPattern(String type) {
        return type.replaceAll("(?<=\\().*?(?=\\))", "%");
    }


//    private void debugRawFields(List<RawField> rawFields) {
//        for (RawField rawField : rawFields) {
//            System.out.println(rawField.toString());
//        }
//    }

}
