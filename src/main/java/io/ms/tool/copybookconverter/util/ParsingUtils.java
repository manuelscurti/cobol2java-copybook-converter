package io.ms.tool.copybookconverter.util;

import io.ms.tool.copybookconverter.converter.xml.Field;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ParsingUtils {

    public static final int NOT_FOUND = -1;

    public static int searchFirstOccurrence(String[] vector, String keyword) {
        for (int i = 0; i < vector.length; i++) {
            if (vector[i].equals(keyword)) {
                return i;
            }
        }
        return NOT_FOUND;
    }

    public static List<String> paramsToList(String params) {
        return new ArrayList<>(Arrays.asList(params.split(",")));
    }

    public static boolean isPic(Field field) {
        return "pic".equals(field.getType());
    }

    public static boolean isGroup(Field field) {
        return "group".equals(field.getType());
    }

    public static boolean isFiller(Field field) {
        return field.getIgnore() != null && field.getIgnore().equals("true");
    }

}
