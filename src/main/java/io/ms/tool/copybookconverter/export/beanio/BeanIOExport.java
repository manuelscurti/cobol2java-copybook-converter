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
import org.springframework.util.StringUtils;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Component
public class BeanIOExport implements CopybookExport {
    private static final Logger log = LoggerFactory.getLogger(BeanIOExport.class);

    @Autowired
    TypeHandler typeHandler;

    private static final String COMMENT_PATTERN = "<!-- starts at %s -->";

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
        BeanRecord record = new BeanRecord(copybook.getName()+"_RECORD", "it.test."+copybook.getName().toUpperCase(), new ArrayList<>());
        stream.insertRecord(record);

        List<Integer> fieldLengths = new ArrayList<>();
        recursiveStreamGeneration(record, null, copybook.getFields(), 1, fieldLengths);

        String finalizedXml = addComments(streamToString(stream), fieldLengths);

        return finalizedXml;
    }

    private void recursiveStreamGeneration(BeanRecord currentRecord, BeanSegment currentSegment, List<Field> fields, Integer fillerIncrementalId, List<Integer> fieldLengths) {

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
                fieldLengths.add(pattern.getFieldLength());


                if (currentSegment != null) {
                    currentSegment.insertField(beanIOExport.getBeanIOField());
                } else {
                    currentRecord.insertField(beanIOExport.getBeanIOField());
                }
            } else if (ParsingUtils.isGroup(field)) {
                BeanSegment newSegment;
                if (field.getOccurs() > 1) { //TODO:support occursRef
                    newSegment = new BeanSegment(field.getName() + "_list", "list", field.getOccurs(), field.getOccurs(),"it.test."+field.getName().toUpperCase(), new ArrayList<>());
                } else {
                    newSegment = new BeanSegment(field.getName() + "_record", "it.test."+field.getName().toUpperCase(), new ArrayList<>());
                }

                recursiveStreamGeneration(currentRecord, newSegment, field.getField(), fillerIncrementalId, fieldLengths);

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

    private String streamToString(BeanStream stream) {
        JaxbPrinter printer;
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(BeanStream.class);
            printer = new JaxbPrinter();
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            marshaller.marshal(stream, printer);
        } catch (JAXBException e) {
            throw new StreamMarshallException(String.format("Marshaller BeanIO stream to String failed - message: %s", e.toString()), stream);
        }

        String _xml = printer.getString();

        return "<beanio xmlns=\"http://www.beanio.org/2012/03\">" + _xml.substring(_xml.indexOf("\n"));
    }


    private String addComments(String xml, List<Integer> fieldLengths) {
        String[] lines = xml.split("\n");
        List<String> commentedLines = new ArrayList<>();

        long currentLength = 0;
        int i = 0;
        for (String line : lines) {
            String tmp = line;
            if (line.contains("field") && i < fieldLengths.size()) {
                currentLength += fieldLengths.get(i);
                tmp += "\t" + String.format(COMMENT_PATTERN, currentLength);
                i++;
            }
            commentedLines.add(tmp);
        }

        return String.join("\n", commentedLines);
    }

}
