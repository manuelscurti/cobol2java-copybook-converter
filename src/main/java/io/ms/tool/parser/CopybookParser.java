package io.ms.tool.parser;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CopybookParser {

    int fieldsFound = 0;
    List<String> discardedLines;

    public CopybookParser() {
        discardedLines = new ArrayList<>();
    }

    public List<RawField> parse(String filepath) throws IOException {
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
        System.out.println("FIELDS DETECTED: "+fieldsFound);
        System.out.println("DISCARDED LINES: ");
        System.out.println(discardedLines);

        reader.close();

        return rawFields;
    }

    private RawField preprocess(String line) {
        String proc0 = line.trim();

        if (!proc0.contains("PIC")) {
            discardedLines.add(line);
            return null; //filter out this line since it not contains any field definition
        }
        fieldsFound++; //counter

        String proc1 = proc0.substring(0, proc0.lastIndexOf("."));
        String proc2 = proc1.replaceAll("\\s+", ","); //replace all white spaces with a single comma
        String[] tokens = proc2.split(","); //split line into tokens

        if (tokens.length <= 2) {
            discardedLines.add(line);
            return null;
        }

        int indexOfPic = 0;
        for (; indexOfPic < tokens.length && !tokens[indexOfPic].equals("PIC"); indexOfPic++) {
        }

        if (indexOfPic - 2 < 0) {
            discardedLines.add(line);
            return null;
        }

        Integer level = Integer.parseInt(tokens[indexOfPic - 2]);
        String fieldName = tokens[indexOfPic - 1].replaceAll("[:-]", "").toLowerCase();
        String typeDefinition = reconstructTypeField(tokens, indexOfPic);
        List<String> params = parseParams(typeDefinition);
        String typeDefinitionPattern = extractPattern(typeDefinition);

        return new RawField(level, fieldName, typeDefinitionPattern, params);
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
    private List<String> parseParams(String type) {
        Matcher m = Pattern.compile("\\(([^)]+)\\)").matcher(type);
        List<String> params = new ArrayList<>();
        while(m.find()) {
            params.add(m.group(1));
        }

        return params;
    }

    private String extractPattern(String type) {
        return type.replaceAll("(?<=\\().*?(?=\\))", "%");
    }

    private void debugRawFields(List<RawField> rawFields) {
        for (RawField rawField : rawFields) {
            System.out.println(rawField.toString());
        }
    }

}
