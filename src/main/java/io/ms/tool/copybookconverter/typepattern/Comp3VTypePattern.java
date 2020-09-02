package io.ms.tool.copybookconverter.typepattern;

import io.ms.tool.copybookconverter.export.java.IJavaExport;
import io.ms.tool.copybookconverter.export.java.model.JavaField;

import java.util.List;

public class Comp3VTypePattern implements TypePattern, IJavaExport {

    private String name;
    private Integer packedSize; //length of field
    private Integer digits;
    private static final int NUM_REQUIRED_PARAMS = 1;

    private static final String JAVA_PROPERTY = "Comp3 %s;";
    private static final String BEANIO_PATTERN = "<field name=\"%s\" length=\"%d\" typeHandler=\"%s\" format=\"%d\" padding=\" \" />"; //FIXME: configurable by user
    private static final String BEANIO_CUSTOM_TYPEHANDLER = "comp3th"; //FIXME: configurable by user

    public Comp3VTypePattern() {
    }

    @Override
    public void setup(String name, List<String> params) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("Comp3TypePattern must receive 1 parameter");
        }

        this.name = name;
        this.digits = Integer.parseInt(params.get(0));
        this.packedSize = (digits % 2) == 0 ? (digits + 2)/2 : (digits + 1)/2;
    }

    @Override
    public String getBeanIOMap() {
        return String.format(BEANIO_PATTERN, name, packedSize, BEANIO_CUSTOM_TYPEHANDLER, digits);
    }

    @Override
    public JavaField getJavaField() {
        return new JavaField(name, "Comp3", "");
    }
}
