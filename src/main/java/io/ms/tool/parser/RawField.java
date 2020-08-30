package io.ms.tool.parser;

import java.util.ArrayList;
import java.util.List;

public class RawField {

    Integer level;
    String name;
    String typePattern;
    List<String> params;
    String comment;
    boolean isFiller;

    List<RawField> subfields;

    public RawField(Integer level, String name, String typePattern, List<String> params, boolean isFiller) {
        this.level = level;
        this.name = name;
        this.typePattern = typePattern;
        this.params = params;
        this.isFiller = isFiller;
    }

    public RawField(Integer level, String name, String typePattern, List<String> params, boolean isFiller, String comment) {
        this.level = level;
        this.name = name;
        this.typePattern = typePattern;
        this.params = params;
        this.isFiller = isFiller;
        this.comment = comment;
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

    public boolean isFiller() {
        return isFiller;
    }

    public void initSubfields() {
        this.subfields = new ArrayList<>();
    }

    public List<RawField> getSubfields() {
        return subfields;
    }

    public void insertSubfield(RawField subfield) {
        this.subfields.add(subfield);
    }

    @Override
    public String toString() {
        return level + " " + name + " " + typePattern + " " + params;
    }
}
