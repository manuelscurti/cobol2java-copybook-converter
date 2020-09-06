package io.ms.tool.copybookconverter.converter.xml;

import jakarta.xml.bind.annotation.*;

import java.util.List;

/**
 * Represents a copybook, parsed from its original text
 * This object is instantiated by the CopybookParser
 * and used by other components of the system
 */
@XmlRootElement(name="copybook")
@XmlAccessorType(XmlAccessType.FIELD)
public class Copybook {

    @XmlAttribute
    private String name;

    @XmlElement(name = "field")
    private List<Field> fields;

    public Copybook() {
    }

    public Copybook(String name, List<Field> fields) {
        this.name = name;
        this.fields = fields;
    }

    public void insertItem(Field field) {
        fields.add(field);
    }

    public String getName() {
        return name;
    }

    public List<Field> getFields() {
        return fields;
    }
}
