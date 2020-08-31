package io.ms.tool.copybookconverter.core;

import java.util.List;

public class NumberTypePattern implements TypePattern {

    private String name;
    private Integer length;
    private static final int NUM_REQUIRED_PARAMS = 1;

    private static final String JAVA_PROPERTY_SHORT = "Short %s;";
    private static final String JAVA_PROPERTY_INT = "Integer %s;";
    private static final String JAVA_PROPERTY_LONG = "Long %s;";
    private static final String BEANIO_PATTERN = "<field name=\"%s\" length=\"%d\" padding=\"0\" justify=\"right\" />";

    public NumberTypePattern() {
    }

    @Override
    public void setup(String name, List<String> params) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("NumberTypePattern must receive 1 parameter");
        }

        this.name = name;
        this.length = Integer.parseInt(params.get(0));
    }

    @Override
    public String getBeanIOMap() {
        return String.format(BEANIO_PATTERN, name, length);
    }

    @Override
    public String getJavaProperty() {
        if (length >= 1 && length <= 4) {
            return String.format(JAVA_PROPERTY_SHORT, name);
        } else if (length >= 5 && length <= 9) {
            return String.format(JAVA_PROPERTY_INT, name);
        } else {
            return String.format(JAVA_PROPERTY_LONG, name);
        }
    }


}
