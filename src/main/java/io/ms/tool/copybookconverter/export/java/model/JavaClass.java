package io.ms.tool.copybookconverter.export.java.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Java class representing...a Java class!
 */
public class JavaClass {

    String className;
    List<JavaField> fields;

    public JavaClass(String className) {
        this.className = className;
        fields = new ArrayList<>();
    }

    public void insertField(JavaField field) {
        fields.add(field);
    }

    public String getClassName() {
        return className;
    }

    public List<JavaField> getFields() {
        return fields;
    }

    @Override
    public String toString() {
        StringBuilder classStr = new StringBuilder();
        classStr.append("public class ").append(className).append(" {\n\n");
        for (JavaField field : fields) {
            classStr.append("\t").append(field.toString()).append("\n");
        }
        classStr.append("\n}\n");
        classStr.append("//////////////////////////////////////////////////////////////////////////////////");

        return classStr.toString();
    }
}
