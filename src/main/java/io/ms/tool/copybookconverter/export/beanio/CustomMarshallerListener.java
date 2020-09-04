package io.ms.tool.copybookconverter.export.beanio;

import io.ms.tool.copybookconverter.export.beanio.model.BeanField;
import jakarta.xml.bind.Marshaller;

import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;

public class CustomMarshallerListener extends Marshaller.Listener {

    private final XMLStreamWriter xsw;

    public CustomMarshallerListener(XMLStreamWriter xsw) {
        this.xsw = xsw;
    }

    @Override
    public void beforeMarshal(Object source)  {
        try {
            if (source instanceof BeanField) {
                xsw.writeComment("Before:  " + source.toString());
            }
        } catch(XMLStreamException e) {
            // TODO: handle exception
        }
    }

    @Override
    public void afterMarshal(Object source) {
        try {
            if (source instanceof BeanField) {
                xsw.writeComment("After:  " + source.toString());
            }
        } catch(XMLStreamException e) {
            // TODO: handle exception
        }
    }

}
