package io.ms.tool.composer.java;

import io.ms.tool.composer.FileComposer;
import io.ms.tool.converter.Field;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class JavaClassComposer implements FileComposer {

    private static final String headerPattern = "package %s;\n\npublic class %s {\n\n";
    private static final String defaultTrailer = "\n}";

    private String header;
    private List<String> body;
    private String trailer;

    public JavaClassComposer() {
    }

    @Override
    public void composeHeader(String... params) {
        this.header = String.format(headerPattern, params[0], params[1]);
    }

    @Override
    public void composeTrailer(String... params) {
        //not needed for this class
        this.trailer = defaultTrailer;
    }

    @Override
    public void composeBody(List<Field> fields) {
        List<String> body = new ArrayList<>();

        fields.forEach(field -> body.add("\t" + field.getJavaLine() + "\n"));

        this.body = body;
    }

    @Override
    public void saveFile(String filepath) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(filepath));

        writer.write(header);
        for (String str : body) {
            writer.write(str);
        }
        writer.write(trailer);
        writer.flush();

        writer.close();
    }


}
