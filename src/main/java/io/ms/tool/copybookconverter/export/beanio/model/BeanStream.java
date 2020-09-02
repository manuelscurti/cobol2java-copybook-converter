package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.*;

@XmlRootElement(name = "stream")
@XmlAccessorType(XmlAccessType.FIELD)
public class BeanStream {

    @XmlAttribute
    private String name;
    @XmlAttribute
    private String format;

    @XmlElement(name = "record")
    private BeanRecord record;

    public BeanStream() {
    }

    public BeanStream(String name, String format, BeanRecord record) {
        this.name = name;
        this.format = format;
        this.record = record;
    }

    public String getName() {
        return name;
    }

    public String getFormat() {
        return format;
    }

    public BeanRecord getRecord() {
        return record;
    }
}
