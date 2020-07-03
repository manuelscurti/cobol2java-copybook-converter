package io.ms.tool.core;

import java.util.List;

public class StringTypePattern implements TypePattern {

    private String name;
    private Integer length;
    private static final int NUM_REQUIRED_PARAMS = 1;

    private static final String JAVA_PROPERTY_STR = "String %s;";
    private static final String JAVA_PROPERTY_CHAR = "Character %s;";
    private static final String BEANIO_PATTERN = "<field name=\"%s\" length=\"%d\" padding=\" \" />"; //FIXME: configurable by user

    public StringTypePattern() {
    }

    @Override
    public void setup(String name, List<String> params) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("StringTypePattern must receive 1 parameter");
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
        if (length == 1) {
            return String.format(JAVA_PROPERTY_CHAR, name);
        }

        return String.format(JAVA_PROPERTY_STR, name);
    }

}
