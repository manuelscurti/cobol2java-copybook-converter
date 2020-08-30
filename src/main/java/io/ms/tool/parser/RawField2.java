package io.ms.tool.parser;

public class RawField2 {

    String originalLine;
    Integer level;
    String name;
    String comment;

    public RawField2(String originalLine, Integer level, String name, String comment) {
        this.originalLine = originalLine;
        this.level = level;
        this.name = name;
        this.comment = comment;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getOriginalLine() {
        return originalLine;
    }

    public void setOriginalLine(String originalLine) {
        this.originalLine = originalLine;
    }

    @Override
    public String toString() {
        return "RawField{" +
                "originalLine='" + originalLine + '\'' +
                ", level=" + level +
                ", name='" + name + '\'' +
                ", comment='" + comment + '\'' +
                '}';
    }
}
