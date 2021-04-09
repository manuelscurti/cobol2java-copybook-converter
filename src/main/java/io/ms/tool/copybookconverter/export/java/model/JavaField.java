package io.ms.tool.copybookconverter.export.java.model;

/**
 * Java class representing... a Java field.
 */
public class JavaField {

    String name;
    String type;
    String comment;

    public JavaField(String name, String type, String comment) {
        this.name = name;
        this.type = type;
        this.comment = comment;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public String toString() {
        if (comment.isEmpty()) {
            return String.format("private %s %s;", type, name);
        }

        return String.format("private %s %s; //%s", type, name, comment);
    }
}
