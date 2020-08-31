package io.ms.tool.copybookconverter.util;

public class StringUtils {

    public static final int NOT_FOUND = -1;

    public static int searchFirstOccurrence(String[] vector, String keyword) {
        for (int i = 0; i < vector.length; i++) {
            if (vector[i].equals(keyword)) {
                return i;
            }
        }
        return NOT_FOUND;
    }

}
