package io.ms.tool.parser;

import java.util.List;

public class RawField {

    Integer level;
    String name;
    String typePattern;
    List<String> params;

    public RawField(Integer level, String name, String typePattern, List<String> params) {
        this.level = level;
        this.name = name;
        this.typePattern = typePattern;
        this.params = params;
    }

    public String getName() {
        return name;
    }

    public String getTypePattern() {
        return typePattern;
    }

    public Integer getLevel() {
        return level;
    }

    public List<String> getParams() {
        return params;
    }

    @Override
    public String toString() {
        return level + " " + name + " " + typePattern + " " + params;
    }
}
