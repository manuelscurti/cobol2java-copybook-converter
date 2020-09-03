package io.ms.tool.copybookconverter.export.beanio;

import io.ms.tool.copybookconverter.converter.xml.Copybook;
import io.ms.tool.copybookconverter.converter.xml.Field;
import io.ms.tool.copybookconverter.exception.ExportException;
import io.ms.tool.copybookconverter.exception.UnmarshallException;
import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.export.beanio.model.BeanRecord;
import io.ms.tool.copybookconverter.export.beanio.model.BeanSegment;
import io.ms.tool.copybookconverter.export.beanio.model.BeanStream;
import io.ms.tool.copybookconverter.typepattern.FillerTypePattern;
import io.ms.tool.copybookconverter.typepattern.TypeHandler;
import io.ms.tool.copybookconverter.typepattern.TypePattern;
import io.ms.tool.copybookconverter.util.JaxbPrinter;
import io.ms.tool.copybookconverter.util.ParsingUtils;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import jakarta.xml.bind.Unmarshaller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Component
public class BeanIOExport implements CopybookExport {
    private static final Logger log = LoggerFactory.getLogger(BeanIOExport.class);

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

        BeanStream stream = new BeanStream(copybook.getName(), "fixedlength", new ArrayList<>());
        BeanRecord record = new BeanRecord(copybook.getName()+"_RECORD", "it.test", new ArrayList<>());
        stream.insertRecord(record);

        recursiveStreamGeneration(record, null, copybook.getFields(), 1);

        JaxbPrinter printer = new JaxbPrinter();
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(BeanStream.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            jaxbMarshaller.marshal(stream, printer);
        } catch (JAXBException e) {
            log.info(e.toString());
            throw new UnmarshallException("Unable to marshal XML", xmlCopybook);
        }

        return printer.getString();
    }

    private void recursiveStreamGeneration(BeanRecord currentRecord, BeanSegment currentSegment, List<Field> fields, Integer fillerIncrementalId) {

        for (Field field : fields) {
            if (ParsingUtils.isPic(field)) {
                TypePattern pattern;
                IBeanIOExport beanIOExport;
                String fieldName = field.getName();

                if (!ParsingUtils.isFiller(field)){
                    pattern = typeHandler.getHandler(field.getDefinition());
                } else {
                    pattern = new FillerTypePattern();
                    fieldName += fillerIncrementalId;
                    fillerIncrementalId++;
                }
                beanIOExport = (IBeanIOExport) pattern;
                pattern.setup(fieldName, ParsingUtils.paramsToList(field.getParams()));
                if (currentSegment != null) {
                    currentSegment.insertField(beanIOExport.getBeanIOField());
                } else {
                    currentRecord.insertField(beanIOExport.getBeanIOField());
                }
            } else if (ParsingUtils.isGroup(field)) {
                BeanSegment newSegment;
                if (field.getOccurs() > 1) { //TODO:support occursRef
                    newSegment = new BeanSegment(field.getName() + "_list", "list", 0, field.getOccurs(),"it.test", new ArrayList<>());
                } else {
                    newSegment = new BeanSegment(field.getName() + "_record", "it.test", new ArrayList<>());
                }

                recursiveStreamGeneration(currentRecord, newSegment, field.getField(), fillerIncrementalId);

                if (currentSegment != null) {
                    currentSegment.insertField(newSegment);
                } else {
                    currentRecord.insertField(newSegment);
                }
            } else {
                throw new ExportException("Failed to parse field", field);
            }
        }
    }

}
