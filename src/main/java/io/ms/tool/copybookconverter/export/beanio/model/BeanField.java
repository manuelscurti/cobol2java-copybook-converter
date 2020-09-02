package io.ms.tool.copybookconverter.export.beanio.model;


import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "field")
@XmlAccessorType(XmlAccessType.FIELD)
public class BeanField {

    @XmlAttribute
    private String name;
    @XmlAttribute
    private Integer length;
    @XmlAttribute
    private String ignore;
    @XmlAttribute
    private String justify;
    @XmlAttribute
    private String padding;

    public BeanField() {
    }

    public BeanField(String name, Integer length, String ignore, String justify, String padding) {
        this.name = name;
        this.length = length;
        this.ignore = ignore;
        this.justify = justify;
        this.padding = padding;
    }

    public String getName() {
        return name;
    }

    public Integer getLength() {
        return length;
    }

    public String getIgnore() {
        return ignore;
    }

    public String getJustify() {
        return justify;
    }

    public String getPadding() {
        return padding;
    }

}
