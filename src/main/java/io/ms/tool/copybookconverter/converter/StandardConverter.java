package io.ms.tool.copybookconverter.converter;

import io.ms.tool.copybookconverter.converter.xml.Copybook;
import io.ms.tool.copybookconverter.converter.xml.Field;
import io.ms.tool.copybookconverter.exception.MarshalException;
import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.parser.model.GroupField;
import io.ms.tool.copybookconverter.parser.model.PicField;
import io.ms.tool.copybookconverter.parser.model.RawField;
import io.ms.tool.copybookconverter.util.JAXBPrinter;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Standard converter from COBOL copybook to an internal XML representation
 * @author m.scurti
 */
@Component
public class StandardConverter implements CopybookConverter {

    private static final String TRUE_VALUE = "true";

    @Override
    public String convert(List<RawField> fields, String copybookName) {
        Copybook copybook = new Copybook(copybookName, new ArrayList<>());

        BytePosition bytePosition = new BytePosition();
        for (RawField field : fields) {
            recursiveCopybookToXml(field, copybook.getFields(), bytePosition);
        }

        String xmlString = "";
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(Copybook.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            JAXBPrinter printer = new JAXBPrinter();
            jaxbMarshaller.marshal(copybook, printer);

            xmlString = printer.getString();
        } catch (JAXBException e) {
            throw new MarshalException("Exception while extracting copybook intermediate representation", copybook);
        }

        return xmlString;
    }

    @Override
    public String exportTo(CopybookExport exporter, String xmlCopybook) {
        return exporter.export(xmlCopybook);
    }

    /**
     * Recursively visits the parsed Copybook through all the subfields.
     * This method updates the currentGroup passed as parameter.
     * @param start - the starting field
     * @param currentGroup - current visiting group
     */
    private void recursiveCopybookToXml(RawField start, List<Field> currentGroup, BytePosition currentBytePosition) {
        if ((start instanceof PicField)) {
//            System.out.println(start.getOriginalLine());
            currentGroup.add(createPicField((PicField) start));
        } else if ((start instanceof GroupField)) {
//            System.out.println(start.getOriginalLine());
            Field newGroup = createGroupField((GroupField) start);
            for (RawField field : ((GroupField) start).getSubfields()) {
                recursiveCopybookToXml(field, newGroup.getField(), currentBytePosition);
            }
            currentGroup.add(newGroup);
        }
    }

    /**
     * If the field is a PICTURE field than this method is called
     * @param rawField - the original field
     * @return an augmented representation of the PICTURE field
     */
    private Field createPicField(PicField rawField) {
        Field field2 = new Field(
                rawField.getLevel(),
                rawField.getName(),
                rawField.getTypePattern(),
                String.join(",", rawField.getParams()),
                null,
                rawField.getComment(),
                rawField.getDefaultValue()
        );

        if (rawField.isFiller()) {
            field2.setIgnore(TRUE_VALUE);
        }
        return field2;
    }

    /**
     * If the field is a GROUP field than this method is called
     * @param rawField - the original field
     * @return an augmented representation of the GROUP field
     */
    private Field createGroupField(GroupField rawField) {
        return new Field(rawField.getLevel(), rawField.getName(), rawField.getNumberReps(), rawField.getComment());
    }

}
