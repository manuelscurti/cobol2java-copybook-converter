package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.*;

import java.util.List;

@XmlRootElement(name="segment")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(propOrder={"name", "classRef", "collection", "occursRef", "minOccurs", "maxOccurs", "fields"})
public class BeanSegment extends BeanItem {

    @XmlAttribute
    private String collection; //value: list
    @XmlAttribute(name = "class")
    private String classRef;
    @XmlAttribute
    private String occursRef;
    @XmlAttribute
    private Integer minOccurs;
    @XmlAttribute
    private Integer maxOccurs;

    @XmlElements({
            @XmlElement(name = "field", type = BeanField.class),
            @XmlElement(name = "segment", type = BeanSegment.class)
    })
    private List<BeanItem> fields;

    public BeanSegment() {
    }

    public BeanSegment(String name, String classRef, List<BeanItem> fields) {
        super(name);
        this.classRef = classRef;
        this.fields = fields;
    }

    public BeanSegment(String name, String collection, String occursRef, String classRef, List<BeanItem> fields) {
        super(name);
        this.collection = collection;
        this.occursRef = occursRef;
        this.classRef = classRef;
        this.fields = fields;
    }

    public BeanSegment(String name, String collection, Integer minOccurs, Integer maxOccurs, String classRef, List<BeanItem> fields) {
        super(name);
        this.collection = collection;
        this.minOccurs = minOccurs;
        this.maxOccurs = maxOccurs;
        this.classRef = classRef;
        this.fields = fields;
    }

    public void insertField(BeanItem field) {
        fields.add(field);
    }

    public List<BeanItem> getFields() {
        return fields;
    }

    public String getName() {
        return super.getName();
    }

    public String getCollection() {
        return collection;
    }

    public String getOccursRef() {
        return occursRef;
    }

    public Integer getMinOccurs() {
        return minOccurs;
    }

    public Integer getMaxOccurs() {
        return maxOccurs;
    }

    public String getClassRef() {
        return classRef;
    }
}
