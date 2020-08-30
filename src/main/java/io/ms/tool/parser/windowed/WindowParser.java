package io.ms.tool.parser.windowed;

import io.ms.tool.parser.RawField;
import io.ms.tool.util.CobolUtils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class WindowParser {

    int fieldsFound = 0;
    List<String> discardedLines;
    Map<String, RawField> recognizedFields;

    /**
     * Algorithm:
     * Parse text file N lines at a time
     * for each window of N lines:
     *      1. Recognize any field (and check if it was already in the list of recognized fields)
     *      2. Look in the window for any comment talking about the field
     *
     */

    public WindowParser() {
        discardedLines = new ArrayList<>();
    }



    public List<RawField> parse(String filepath) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(filepath));

        String line;
        List<RawField> rawFields = new ArrayList<>();

//        while ((line = reader.readLine()) != null) {
//            RawField rawField = preprocess(line);
//            if (rawField != null) {
//                rawFields.add(rawField);
//            }
//        }



        return null;
    }

    /**
     * Reads next @windowSize lines from file
     * @param reader file handler
     * @param windowSize size of the window
     * @return the next window in the file
     * @throws IOException -
     */
    protected List<String> nextWindow(BufferedReader reader, int windowSize) throws IOException {
        List<String> window = new ArrayList<>();

        String line;
        for (int i = 0; i < windowSize && (line = reader.readLine()) != null; i++) {
            window.add(line);
        }

        return window;
    }

    /**
     * Checks whether the comment talks about the field
     * @param fieldName
     * @param comment
     * @return
     */
    protected int checkSimilarity(String fieldName, String comment) {
        int commonChars = 0;

        String cleanComment = comment.replaceAll("\\s+", "");

        for (int i = 0; i < fieldName.length() && i < comment.length(); i++) {
            if (fieldName.charAt(i) == comment.charAt(i)) {
                commonChars++;
            }
        }

        return -1;
    }


    protected boolean windowProcessor(List<String> window) {


        return false;
    }

    protected String lineProcessor(String line) {
        String proc0 = line.trim();

        if (!proc0.contains("PIC")) {
            discardedLines.add(line);
            return null; //filter out this line since does not contain any field definition
        }

        if (CobolUtils.isLineCommented(proc0)) {
            discardedLines.add(line);
            return null;
        }

        fieldsFound++; //counter

        //clean up
        String proc1 = proc0.substring(0, proc0.lastIndexOf("."));
        String proc2 = proc1.replaceAll("\\s+", ","); //replace all white spaces with a single comma

        //integrity check: cobol fields are defined by at least 3 tokens, e.g. 05 NAME PIC X(3)
        String[] tokens = proc2.split(","); //split line into tokens
        if (tokens.length <= 2) {
            discardedLines.add(line);
            return null;
        }

        //finds the position of the PIC token inside the line
        int indexOfPic = 0;
        for (; indexOfPic < tokens.length && !tokens[indexOfPic].equals("PIC"); indexOfPic++) {
        }

        //integrity check: level is always specified in cobol fields
        if (indexOfPic - 2 < 0) {
            discardedLines.add(line);
            return null;
        }

        RawField field = parseField(tokens, indexOfPic);

        recognizedFields.put(field.getName(), field);

        return null;
    }

    protected RawField parseField(String[] tokens, int indexOfPic) {
        Integer level = Integer.parseInt(tokens[indexOfPic - 2]);
        String fieldName = tokens[indexOfPic - 1].replaceAll("[:-]", "").toLowerCase();
        String typeDefinition = reconstructTypeField(tokens, indexOfPic);
        List<String> params = parseParams(typeDefinition);
        String typeDefinitionPattern = extractPattern(typeDefinition);

        return new RawField(level, fieldName, typeDefinitionPattern, params, false);
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

}
