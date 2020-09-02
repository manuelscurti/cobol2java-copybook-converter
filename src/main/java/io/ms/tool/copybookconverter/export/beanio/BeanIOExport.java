package io.ms.tool.copybookconverter.export.beanio;

import io.ms.tool.copybookconverter.converter.xml.Copybook;
import io.ms.tool.copybookconverter.exception.UnmarshallException;
import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.typepattern.TypeHandler;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Unmarshaller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

@Component
public class BeanIOExport implements CopybookExport {

    @Autowired
    TypeHandler typeHandler;

    @Override
    public String export(String xmlCopybook) {
        Copybook copybook;

        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(Copybook.class);
            Unmarshaller jaxbMarshaller = jaxbContext.createUnmarshaller();
            InputStream targetStream = new ByteArrayInputStream(xmlCopybook.getBytes());
            copybook = (Copybook) jaxbMarshaller.unmarshal(targetStream);
        } catch (JAXBException e) {
            throw new UnmarshallException("XML format not recognized", xmlCopybook);
        }

        if (copybook == null) {
            return null;
        }


        return null;
    }
}
