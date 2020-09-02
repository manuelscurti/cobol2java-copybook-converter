package io.ms.tool.copybookconverter.converter;

import io.ms.tool.copybookconverter.converter.xml.Copybook;
import io.ms.tool.copybookconverter.converter.xml.Field;
import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.parser.model.GroupField;
import io.ms.tool.copybookconverter.parser.model.PicField;
import io.ms.tool.copybookconverter.parser.model.RawField;
import io.ms.tool.copybookconverter.util.CopybookPrinter;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class StandardConverter implements CopybookConverter {

    private static final String TRUE_VALUE = "true";

    @Override
    public String convert(List<RawField> fields, String copybookName) {
        Copybook copybook = new Copybook(copybookName, new ArrayList<>());

        for (RawField field : fields) {
            depthFirstVisit(field, copybook.getFields());
        }

        String xmlString = "";
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(Copybook.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            CopybookPrinter printer = new CopybookPrinter();
            jaxbMarshaller.marshal(copybook, printer);

            xmlString = printer.getString();
        } catch (JAXBException e) {
            e.printStackTrace();
        }

        return xmlString;
    }

    @Override
    public String exportTo(CopybookExport exporter, String xmlCopybook) {
        return exporter.export(xmlCopybook);
    }

    private void depthFirstVisit(RawField start, List<Field> currentGroup) {
        if ((start instanceof PicField)) {
            System.out.println(start.getOriginalLine());
            currentGroup.add(createPicField((PicField) start));
        } else if ((start instanceof GroupField)) {
            System.out.println(start.getOriginalLine());
            Field newGroup = createGroupField((GroupField) start);
            for (RawField field : ((GroupField) start).getSubfields()) {
                depthFirstVisit(field, newGroup.getField());
            }
            currentGroup.add(newGroup);
        }
    }

    private Field createPicField(PicField rawField) {
        Field field2 = new Field(rawField.getLevel(),
                                    rawField.getName(),
                                    rawField.getTypePattern(),
                                    String.join(",", rawField.getParams()),
                                    null,
                                    rawField.getComment()
        );

        if (rawField.isFiller()) {
            field2.setIgnore(TRUE_VALUE);
        }
        return field2;
    }

    private Field createGroupField(GroupField rawField) {
        return new Field(rawField.getLevel(), rawField.getName(), rawField.getNumberReps(), rawField.getComment());
    }

}
