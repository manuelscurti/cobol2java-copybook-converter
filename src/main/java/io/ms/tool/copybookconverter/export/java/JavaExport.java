package io.ms.tool.copybookconverter.export.java;

import io.ms.tool.copybookconverter.converter.xml.Copybook;
import io.ms.tool.copybookconverter.converter.xml.Field;
import io.ms.tool.copybookconverter.exception.ExportException;
import io.ms.tool.copybookconverter.exception.UnmarshallException;
import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.export.java.model.JavaClass;
import io.ms.tool.copybookconverter.export.java.model.JavaField;
import io.ms.tool.copybookconverter.typepattern.TypeHandler;
import io.ms.tool.copybookconverter.typepattern.TypePattern;
import io.ms.tool.copybookconverter.util.ParsingUtils;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Unmarshaller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Component
public class JavaExport implements CopybookExport {

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

        List<JavaClass> classesList = new ArrayList<>();
        JavaClass mainClass = new JavaClass("AN000233");
        classesList.add(mainClass);

        recursiveClassGeneration(classesList, mainClass, copybook.getFields());

        StringBuilder output = new StringBuilder();
        for (JavaClass javaClass : classesList) {
            output.append(javaClass.toString()).append("\n");
        }

        return output.toString();
    }


    private void recursiveClassGeneration(List<JavaClass> classesList, JavaClass currentClass, List<Field> fields) {

        for (Field field : fields) {
            if (ParsingUtils.isPic(field)) {
                if (!ParsingUtils.isFiller(field)){
                    TypePattern pattern = typeHandler.getHandler(field.getDefinition());
                    IJavaExport IJavaExport = (IJavaExport) pattern;
                    pattern.setup(field.getName(), ParsingUtils.paramsToList(field.getParams()));
                    currentClass.insertField(IJavaExport.getJavaField());
                }
            } else if (ParsingUtils.isGroup(field)) {
                JavaClass newClass = new JavaClass(field.getName().toUpperCase());

                recursiveClassGeneration(classesList, newClass, field.getField());

                String type = (field.getOccurs() > 1) ? "List<"+field.getName().toUpperCase()+">" : field.getName().toUpperCase();
                String fieldName = (field.getOccurs() > 1) ? field.getName()+"_list" : field.getName()+"_record";

                currentClass.insertField(new JavaField(fieldName, type, ""));
                classesList.add(newClass);
            } else {
                throw new ExportException("Failed to parse field", field);
            }
        }

    }

}
