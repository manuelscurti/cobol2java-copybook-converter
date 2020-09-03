package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.*;

import java.util.List;

@XmlRootElement(name="record")
@XmlAccessorType(XmlAccessType.FIELD)
public class BeanRecord {

    @XmlAttribute
    String name;
    @XmlAttribute
    String classPackage;

    @XmlElements({
            @XmlElement(name = "field", type = BeanField.class),
            @XmlElement(name = "segment", type = BeanSegment.class)
    })
    private List<BeanItem> fields;

    public BeanRecord() {
    }

    public BeanRecord(String name, String classPackage, List<BeanItem> fields) {
        this.name = name;
        this.classPackage = classPackage;
        this.fields = fields;
    }

    public void insertField(BeanItem field) {
        fields.add(field);
    }

    public String getName() {
        return name;
    }

    public String getClassPackage() {
        return classPackage;
    }

    public List<BeanItem> getFields() {
        return fields;
    }
}
