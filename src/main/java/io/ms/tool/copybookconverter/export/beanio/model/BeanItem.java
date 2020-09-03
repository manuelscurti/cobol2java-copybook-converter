package io.ms.tool.copybookconverter.export.beanio.model;

import jakarta.xml.bind.annotation.*;

@XmlTransient
public abstract class BeanItem {

    @XmlAttribute
    private String name;

    public BeanItem() {
    }

    public BeanItem(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
