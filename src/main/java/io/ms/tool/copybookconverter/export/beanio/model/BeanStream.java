package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.*;

import java.util.List;

@XmlRootElement(name="stream")
@XmlAccessorType(XmlAccessType.FIELD)
public class BeanStream {

    @XmlAttribute
    private String name;
    @XmlAttribute
    private String format;

    @XmlElement(name = "record")
    private List<BeanRecord> records;

    public BeanStream() {
    }

    public BeanStream(String name, String format, List<BeanRecord> records) {
        this.name = name;
        this.format = format;
        this.records = records;
    }

    public String getName() {
        return name;
    }

    public String getFormat() {
        return format;
    }

    public List<BeanRecord> getRecords() {
        return records;
    }

    public void insertRecord(BeanRecord record) {
        records.add(record);
    }
}
