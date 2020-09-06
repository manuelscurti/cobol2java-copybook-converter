package io.ms.tool.copybookconverter.converter.xml;

import jakarta.xml.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents a field or a group of fields
 */
@XmlRootElement(name = "field")
@XmlAccessorType(XmlAccessType.FIELD)
public class Field {

    @XmlAttribute
    Integer h; //level id
    @XmlAttribute
    String name;
    @XmlAttribute
    String type;
    @XmlAttribute
    String definition;
    @XmlAttribute
    String params;
    @XmlAttribute
    String comment;
    @XmlAttribute
    String ignore;
    @XmlAttribute
    Integer occurs;
    @XmlAttribute
    String defaultValue;

    List<Field> field = new ArrayList<>();

    public Field() {
    }

    public Field(Integer level, String name, Integer occurs, String comment) {
        this.h = level;
        this.name = name;
        this.type = "group";
        this.comment = comment;
        this.occurs = occurs;
    }

    public Field(Integer level, String name, String definition, String params, String ignore, String comment, String defaultValue) {
        this.h = level;
        this.name = name;
        this.type = "pic";
        this.definition = definition;
        this.params = params;
        this.ignore = ignore;
        this.comment = comment;
        this.defaultValue = defaultValue;
    }

    public Integer getH() {
        return h;
    }

    public void setH(Integer h) {
        this.h = h;
    }

    public void insertField(Field field) {
        this.field.add(field);
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

    public String getDefinition() {
        return definition;
    }

    public void setDefinition(String definition) {
        this.definition = definition;
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getIgnore() {
        return ignore;
    }

    public void setIgnore(String ignore) {
        this.ignore = ignore;
    }

    public Integer getOccurs() {
        return occurs;
    }

    public void setOccurs(Integer occurs) {
        this.occurs = occurs;
    }

    public List<Field> getField() {
        return field;
    }

    public void setField(List<Field> field) {
        this.field = field;
    }

    public String getDefaultValue() {
        return defaultValue;
    }
}
