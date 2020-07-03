package io.ms.tool.converter;

public class Field {

    private String beanIOLine;
    private String javaLine;

    public Field(String beanIOLine, String javaLine) {
        this.beanIOLine = beanIOLine;
        this.javaLine = javaLine;
    }

    public String getBeanIOLine() {
        return beanIOLine;
    }

    public String getJavaLine() {
        return javaLine;
    }

    @Override
    public String toString() {
        return "Field{" +
                "beanIOLine='" + beanIOLine + '\'' +
                ", javaLine='" + javaLine + '\'' +
                '}';
    }
}
