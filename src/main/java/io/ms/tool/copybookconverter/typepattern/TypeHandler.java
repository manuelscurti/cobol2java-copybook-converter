package io.ms.tool.copybookconverter.typepattern;

import org.springframework.stereotype.Component;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Component
public class TypeHandler {

    private final Map<String, TypePattern> conversionMap;
    static final String DEFAULT_PATTERN = CobolType.STRING_1.getPattern();

    //STATS
    private int failedRecognition = 0;
    private final Set<String> nonRecognizedFieldsDetailed;

    public TypeHandler() throws NoSuchMethodException, IllegalAccessException, InvocationTargetException, InstantiationException {
        conversionMap = new HashMap<>();
        nonRecognizedFieldsDetailed = new HashSet<>();
        for (CobolType type : CobolType.values()) {
            conversionMap.put(type.getPattern(), (TypePattern) type.getParser().getDeclaredConstructor().newInstance());
        }
    }

    public TypePattern getHandler(String typeDefinition) {
        if (!conversionMap.containsKey(typeDefinition)) {
            failedRecognition++;
            nonRecognizedFieldsDetailed.add(typeDefinition);
            return null;
        }

        return conversionMap.get(typeDefinition);
    }

}
