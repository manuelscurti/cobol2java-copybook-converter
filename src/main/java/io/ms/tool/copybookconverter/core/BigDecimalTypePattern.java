package io.ms.tool.copybookconverter.core;

import java.util.List;

public class BigDecimalTypePattern implements TypePattern {

    private String name;
    private Integer length;
    private static final int NUM_REQUIRED_PARAMS = 1;

    private static final String JAVA_PROPERTY = "BigDecimal %s;";
    private static final String BEANIO_PATTERN = "<field name=\"%s\" length=\"%d\" padding=\" \" />";

    public BigDecimalTypePattern() {
    }

    @Override
    public void setup(String name, List<String> params) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("BigDecimalTypePattern must receive 1 parameter");
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
        return String.format(JAVA_PROPERTY, name);
    }

}
