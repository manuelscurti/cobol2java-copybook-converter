package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.*;

import java.util.List;

@XmlRootElement(name = "record")
@XmlAccessorType(XmlAccessType.FIELD)
public class BeanRecord {

    @XmlAttribute
    String name;
    @XmlAttribute
    String classPackage;

    @XmlElement(name = "field")
    private List<BeanField> fields;

    public BeanRecord() {
    }

    public BeanRecord(String name, String classPackage, List<BeanField> fields) {
        this.name = name;
        this.classPackage = classPackage;
        this.fields = fields;
    }

    public void insertField(BeanField field) {
        fields.add(field);
    }

    public String getName() {
        return name;
    }

    public String getClassPackage() {
        return classPackage;
    }

    public List<BeanField> getFields() {
        return fields;
    }
}
