package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.Marshaller;
import jakarta.xml.bind.annotation.*;

@XmlRootElement(name="field")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(propOrder={"name", "length", "typeHandler", "format", "justify", "padding", "ignore", "defaultValue"})
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
    @XmlAttribute(name = "default")
    private String defaultValue;

    public BeanField() {
    }

    public BeanField(String name, Integer length, String typeHandler, String format, String ignore, String justify, String padding, String defaultValue) {
        super(name);
        this.length = length;
        this.typeHandler = typeHandler;
        this.format = format;
        this.ignore = ignore;
        this.justify = justify;
        this.padding = padding;
        this.defaultValue = defaultValue;
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

    public String getDefaultValue() {
        return defaultValue;
    }

}
