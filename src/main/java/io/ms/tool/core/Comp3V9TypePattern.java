package io.ms.tool.core;

import java.util.List;

public class Comp3V9TypePattern implements TypePattern {

    private String name;
    private Integer packedSize; //length of field
    private Integer integerPlaces; //length of integer part
    private Integer decimalPlaces; //length of decimal part
    private static final int NUM_REQUIRED_PARAMS = 2;

    private static final String JAVA_PROPERTY = "Comp3V9 %s;";
    private static final String BEANIO_PATTERN = "<field name=\"%s\" length=\"%d\" typeHandler=\"%s\" format=\"%d,%d\" padding=\" \" />"; //FIXME: configurable by user
    private static final String BEANIO_CUSTOM_TYPEHANDLER = "comp3v9th"; //FIXME: configurable by user

    public Comp3V9TypePattern() {
    }

    @Override
    public void setup(String name, List<String> params) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("Comp3V9TypePattern must receive 2 parameters");
        }

        this.name = name;
        this.integerPlaces = Integer.parseInt(params.get(0));
        this.decimalPlaces = Integer.parseInt(params.get(1));
        int sum = this.integerPlaces + this.decimalPlaces;
        this.packedSize = (sum % 2) == 0 ? (sum + 2)/2 : (sum + 1)/2;
    }

    @Override
    public String getBeanIOMap() {
        return String.format(BEANIO_PATTERN, name, packedSize, BEANIO_CUSTOM_TYPEHANDLER, integerPlaces, decimalPlaces);
    }

    @Override
    public String getJavaProperty() {
        return String.format(JAVA_PROPERTY, name);
    }
}
