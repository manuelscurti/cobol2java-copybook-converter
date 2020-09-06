package io.ms.tool.copybookconverter.typepattern;

import io.ms.tool.copybookconverter.export.beanio.IBeanIOExport;
import io.ms.tool.copybookconverter.export.beanio.model.BeanField;
import io.ms.tool.copybookconverter.export.java.IJavaExport;
import io.ms.tool.copybookconverter.export.java.model.JavaField;

import java.util.List;

public class NumberTypePattern implements TypePattern, IJavaExport, IBeanIOExport {

    private String name;
    private Integer length;
    private String comment;
    private String defaultValue;
    private static final int NUM_REQUIRED_PARAMS = 1;

    private static final String JAVA_PROPERTY_SHORT = "Short %s;";
    private static final String JAVA_PROPERTY_INT = "Integer %s;";
    private static final String JAVA_PROPERTY_LONG = "Long %s;";
    private static final String BEANIO_PATTERN = "<field name=\"%s\" length=\"%d\" padding=\"0\" justify=\"right\" />";

    public NumberTypePattern() {
    }

    @Override
    public void setup(String name, List<String> params, String comment, String defaultValue) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("NumberTypePattern must receive 1 parameter");
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
        if (length >= 1 && length <= 4) {
            javaType = "Short";
        } else if (length >= 5 && length <= 9) {
            javaType = "Integer";
        } else {
            javaType = "Long";
        }
        return new JavaField(name, javaType, "");
    }

    @Override
    public BeanField getBeanIOField() {
        return new BeanField(name, length, null, null, null, "right", "0", defaultValue);
    }
}
