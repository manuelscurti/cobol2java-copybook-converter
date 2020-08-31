package io.ms.tool.converter;

import io.ms.tool.core.CobolType;
import io.ms.tool.core.TypePattern;
import io.ms.tool.parser.RawField_old;

import java.lang.reflect.InvocationTargetException;
import java.util.*;

public class CopybookConverter {
    Map<String, TypePattern> conversionMap;
    int nonRecognizedField = 0;
    Set<String> unrecognizedType;
    static final String defaultPattern = CobolType.STRING_1.getPattern();

    public CopybookConverter() throws NoSuchMethodException, IllegalAccessException, InvocationTargetException, InstantiationException {
        conversionMap = new HashMap<>();
        unrecognizedType = new HashSet<>();
        for (CobolType type : CobolType.values()) {
            conversionMap.put(type.getPattern(), (TypePattern) type.getParser().getDeclaredConstructor().newInstance());
        }
    }


    public List<Field> convert(List<RawField_old> rawFields) {
        List<Field> fields = new ArrayList<>();

        for (RawField_old rawField : rawFields) {
            if (conversionMap.containsKey(rawField.getTypePattern())) {
                fields.add(convertField(conversionMap.get(rawField.getTypePattern()), rawField));
            } else {
                nonRecognizedField++;
                unrecognizedType.add(rawField.getTypePattern());
                //if possible -> by default map to string
                if (rawField.getParams().size() == 1) {
                    fields.add(convertField(conversionMap.get(defaultPattern), rawField));
                }
            }
        }

        System.out.println(String.format("CONVERTED FIELDS: %d/%d", rawFields.size() - nonRecognizedField, rawFields.size()));
        System.out.println(String.format("-> TOTAL LENGTH OF FIELDS: %d", nonRecognizedField));
        System.out.println(String.format("-> NON RECOGNIZED FIELDS: %d", nonRecognizedField));
        System.out.println("DETAILS: ");

        System.out.println(unrecognizedType);

        return fields;
    }

    private Field convertField(TypePattern typeConverter, RawField_old rawField) {
        typeConverter.setup(rawField.getName(), rawField.getParams());
        Field finalField = new Field(typeConverter.getBeanIOMap(), typeConverter.getJavaProperty());
        System.out.println(finalField);
        return finalField;
    }

}
