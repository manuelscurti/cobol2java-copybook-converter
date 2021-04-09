package io.ms.tool.copybookconverter.typepattern;

import io.ms.tool.copybookconverter.export.beanio.IBeanIOExport;
import io.ms.tool.copybookconverter.export.beanio.model.BeanField;
import io.ms.tool.copybookconverter.export.java.IJavaExport;
import io.ms.tool.copybookconverter.export.java.model.JavaField;

import java.util.List;

public class StringTypePattern implements TypePattern, IJavaExport, IBeanIOExport {

    private String name;
    private Integer length;
    private String comment;
    private String defaultValue;
    private static final int NUM_REQUIRED_PARAMS = 1;

    private static final String JAVA_PROPERTY_STR = "String %s;";
    private static final String JAVA_PROPERTY_CHAR = "Character %s;";
    private static final String BEANIO_PATTERN = "<field name=\"%s\" length=\"%d\" padding=\" \" />"; //FIXME: configurable by user

    public StringTypePattern() {
    }

    @Override
    public void setup(String name, List<String> params, String comment, String defaultValue) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("StringTypePattern must receive 1 parameter");
        }

        this.name = name;
        this.length = Integer.parseInt(params.get(0));
        this.comment = comment;
        this.defaultValue = defaultValue;
    }

    @Override
    public int getFieldLength() {
        return length;
    }

    @Override
    public JavaField getJavaField() {
        String javaType;
        if (length == 1) {
            javaType = "Character";
        } else {
            javaType = "String";
        }

        return new JavaField(name, javaType, "");
    }

    @Override
    public BeanField getBeanIOField() {
        return new BeanField(name, length, null, null, null, null, null, defaultValue);
    }
}
