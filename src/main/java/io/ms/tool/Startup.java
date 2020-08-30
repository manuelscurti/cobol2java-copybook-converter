package io.ms.tool;

import io.ms.tool.composer.beanio.BeanIOStreamComposer;
import io.ms.tool.composer.java.JavaClassComposer;
import io.ms.tool.converter.CopybookConverter;
import io.ms.tool.converter.Field;
import io.ms.tool.parser.StandardParser;
import io.ms.tool.parser.RawField;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

public class Startup {

    public static void main(String[] args) throws IOException, InvocationTargetException, NoSuchMethodException, InstantiationException, IllegalAccessException {

        StandardParser standardParser = new StandardParser();
        CopybookConverter copybookConverter = new CopybookConverter();

//        List<RawField> fields = copybookParser.parse("src/main/resources/TW00DCMI.cpy");
//        List<RawField> fields = copybookParser.parse("src/main/resources/BE300W01.cpy");
        List<RawField> fields = standardParser.parse("src/main/resources/AN006253.cpy");
        List<Field> convertedFields = copybookConverter.convert(fields);

        JavaClassComposer javaClassComposer = new JavaClassComposer();

        javaClassComposer.composeHeader("it.cedacri.an.data.model", "AN006253");
        javaClassComposer.composeBody(convertedFields);
        javaClassComposer.composeTrailer();

        javaClassComposer.saveFile("src/main/resources/AN006253.java");

        BeanIOStreamComposer beanIOStreamComposer = new BeanIOStreamComposer();

        beanIOStreamComposer.composeHeader("AN006253", "it.cedacri.an.data.model.AN006253", "comp3v9th,it.cedacri.util.typehandler.comp.Comp3TypeHandler", "compth,it.cedacri.util.typehandler.comp.UCompTypeHandler");
        beanIOStreamComposer.composeBody(convertedFields);
        beanIOStreamComposer.composeTrailer();

        beanIOStreamComposer.saveFile("src/main/resources/AN006253.xml");

//        Deque<String> window = new ArrayDeque<>();

//        String[] file = new String[] { "prima linea", "seconda linea", "terza linea", "quarta linea", "quinta linea", "sesta linea"};
//
//        for (String line : file) {
//            window.addFirst(line);
//            if (window.size() > 3) {
//                window.removeLast();
//            }
//        }

//        System.out.println(window);


    }

}
