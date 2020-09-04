package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.*;

import java.util.List;

@XmlRootElement(name="record")
@XmlAccessorType(XmlAccessType.FIELD)
public class BeanRecord {

    @XmlAttribute
    String name;
    @XmlAttribute(name = "class")
    String classRef;

    @XmlElements({
            @XmlElement(name = "field", type = BeanField.class),
            @XmlElement(name = "segment", type = BeanSegment.class)
    })
    private List<BeanItem> fields;

    public BeanRecord() {
    }

    public BeanRecord(String name, String classRef, List<BeanItem> fields) {
        this.name = name;
        this.classRef = classRef;
        this.fields = fields;
    }

    public void insertField(BeanItem field) {
        fields.add(field);
    }

    public String getName() {
        return name;
    }

    public String getClassRef() {
        return classRef;
    }

    public List<BeanItem> getFields() {
        return fields;
    }
}
