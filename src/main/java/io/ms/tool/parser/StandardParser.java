package io.ms.tool.parser;

import io.ms.tool.util.CobolUtils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Standard copybook parser
 * It does not provide any extra functionality such as: smart variable naming
 *
 *
 * formats:
 * [level] [field name] PIC [type]  --supported
 * [level] FILLER PIC X([num])      --supported
 * [level] [field name]             --
 * [level] [field name] OCCURS [number of reps]
 *
 * minimum number of tokens to be a valid candidate: 2
 *
 */
public class StandardParser implements CopybookParser {
    ParserStats stats;

    private static final int MINIMUM_TOKEN_NUMBER = 2; //to be a valid candidate to become a field

    @Override
    public List<RawField> parse(String filepath) throws IOException {
        stats = new ParserStats(); //reset stats
        BufferedReader reader = new BufferedReader(new FileReader(filepath));

        String line;
        List<RawField> rawFields = new ArrayList<>();

        while ((line = reader.readLine()) != null) {
            RawField rawField = preprocess(line);
            if (rawField != null) {
                rawFields.add(rawField);
            }
        }

//        debugRawFields(rawFields);
        System.out.println("FIELDS DETECTED: "+stats.getTotalDetectedFields());
        System.out.println("DISCARDED LINES: ");
        System.out.println(stats.getDiscardedLines());

        reader.close();

        return rawFields;
    }

    @Override
    public ParserStats inspectParser() {
        return stats;
    }

    private RawField preprocess(String line) {
        String proc0 = line.trim();

        //FIXME: to be hierarchy preserving, this control here has to be deprecated
        if (!CobolUtils.containsFieldSpecs(proc0)) {
            stats.insertDiscardedLine(line);
            return null;
        }

        if (CobolUtils.isLineCommented(proc0)) {
            stats.insertDiscardedLine(line);
            return null;
        }

        stats.newDetectedFields(); //increment internal counter

        String proc1 = proc0.substring(0, proc0.lastIndexOf("."));
        String proc2 = proc1.replaceAll("\\s+", ","); //replace all white spaces with a single comma
        String[] tokens = proc2.split(","); //split line into tokens

        if (tokens.length < MINIMUM_TOKEN_NUMBER) { //cobol fields are defined by at least 3 tokens, e.g. 05 NAME PIC X(3)
            stats.insertDiscardedLine(line);
            return null;
        }

        int indexOfPic = 0;
        for (; indexOfPic < tokens.length && !tokens[indexOfPic].equals("PIC"); indexOfPic++) {
        }

        if (indexOfPic - 2 < 0) {
            stats.insertDiscardedLine(line);
            return null;
        }

        Integer level = Integer.parseInt(tokens[indexOfPic - 2]);
        String fieldName = tokens[indexOfPic - 1].replaceAll("[:-]", "").toLowerCase();
        String typeDefinition = reconstructTypeField(tokens, indexOfPic);
        List<String> params = parseFieldParams(typeDefinition);
        String typeDefinitionPattern = extractPattern(typeDefinition);
        boolean isFiller = CobolUtils.isFiller(fieldName);
        if (isFiller) {
            stats.newFillerField();
        }

        return new RawField(level, fieldName, typeDefinitionPattern, params, isFiller);
    }

    private String reconstructTypeField(String[] tokens, int indexOfPic) {
        StringBuilder typeBuilder = new StringBuilder();

        //join remaining tokens which define the type of the field
        for (int i = indexOfPic + 1; i < tokens.length; i++) {
            typeBuilder.append(tokens[i]);
            typeBuilder.append(" ");
        }

        String reconstructedType = typeBuilder.toString().trim();
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


    private void debugRawFields(List<RawField> rawFields) {
        for (RawField rawField : rawFields) {
            System.out.println(rawField.toString());
        }
    }

}
