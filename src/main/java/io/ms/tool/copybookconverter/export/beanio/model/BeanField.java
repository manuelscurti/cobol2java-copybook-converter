package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.Marshaller;
import jakarta.xml.bind.annotation.*;

@XmlRootElement(name="field")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(propOrder={"name", "length", "typeHandler", "format", "justify", "padding", "ignore"})
public class BeanField extends BeanItem {

    @XmlAttribute
    private Integer length;
    @XmlAttribute
    private String typeHandler;
    @XmlAttribute
    private String format;
    @XmlAttribute
    private String ignore;
    @XmlAttribute
    private String justify;
    @XmlAttribute
    private String padding;

    public BeanField() {
    }

    public BeanField(String name, Integer length, String typeHandler, String format, String ignore, String justify, String padding) {
        super(name);
        this.length = length;
        this.typeHandler = typeHandler;
        this.format = format;
        this.ignore = ignore;
        this.justify = justify;
        this.padding = padding;
    }

    public String getName() {
        return super.getName();
    }

    public String getFormat() {
        return format;
    }

    public String getTypeHandler() {
        return typeHandler;
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

//    // Invoked by Marshaller after it has created an instance of this object.
//    boolean beforeMarshal(Marshaller marshaller) {
//        System.out.println("Before Marshaller Callback");
//        return true;
//    }
//
//    // Invoked by Marshaller after it has marshalled all properties of this object.
//    void afterMarshal(Marshaller marshaller) {
//        System.out.println("After Marshaller Callback");
//    }

}
