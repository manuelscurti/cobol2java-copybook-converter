package io.ms.tool;

import io.ms.tool.composer.beanio.BeanIOStreamComposer;
import io.ms.tool.composer.java.JavaClassComposer;
import io.ms.tool.converter.CopybookConverter;
import io.ms.tool.converter.Field;
import io.ms.tool.parser.CopybookParser;
import io.ms.tool.parser.RawField;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

public class Startup {

    public static void main(String[] args) throws IOException, InvocationTargetException, NoSuchMethodException, InstantiationException, IllegalAccessException {

        CopybookParser copybookParser = new CopybookParser();
        CopybookConverter copybookConverter = new CopybookConverter();

//        List<RawField> fields = copybookParser.parse("src/main/resources/TW00DCMI.cpy");
        List<RawField> fields = copybookParser.parse("src/main/resources/TE000902.cpy");
        List<Field> convertedFields = copybookConverter.convert(fields);

        JavaClassComposer javaClassComposer = new JavaClassComposer();

        javaClassComposer.composeHeader("io.ms.tool", "TE000902");
        javaClassComposer.composeBody(convertedFields);
        javaClassComposer.composeTrailer();

        javaClassComposer.saveFile("src/main/resources/TE000902.java");

        BeanIOStreamComposer beanIOStreamComposer = new BeanIOStreamComposer();

        beanIOStreamComposer.composeHeader("TE000902", "io.ms.tool.TE000902", "comp3v9th,io.ms.tool.Comp3TypeHandler", "compth,io.ms.tool.UCompTypeHandler");
        beanIOStreamComposer.composeBody(convertedFields);
        beanIOStreamComposer.composeTrailer();

        beanIOStreamComposer.saveFile("src/main/resources/KPC00179.xml");

    }

}
