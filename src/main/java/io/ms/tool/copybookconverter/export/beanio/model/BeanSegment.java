package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "segment")
@XmlAccessorType(XmlAccessType.FIELD)
public class BeanSegment {

    @XmlAttribute
    private String name;
    @XmlAttribute
    private String collection;
    @XmlAttribute
    private String occursRef;
    @XmlAttribute
    private Integer minOccurs;
    @XmlAttribute
    private Integer maxOccurs;
    @XmlAttribute
    private String classRef;

    public BeanSegment() {
    }

    public BeanSegment(String name, String collection, String occursRef, String classRef) {
        this.name = name;
        this.collection = collection;
        this.occursRef = occursRef;
        this.classRef = classRef;
    }

    public BeanSegment(String name, String collection, Integer minOccurs, Integer maxOccurs, String classRef) {
        this.name = name;
        this.collection = collection;
        this.minOccurs = minOccurs;
        this.maxOccurs = maxOccurs;
        this.classRef = classRef;
    }

    public String getName() {
        return name;
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
