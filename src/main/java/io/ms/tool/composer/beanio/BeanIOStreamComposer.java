package io.ms.tool.composer.beanio;

import io.ms.tool.composer.FileComposer;
import io.ms.tool.converter.Field;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 *     <stream name="FIXED_RECORDS" format="fixedlength">
 *         <record name="record1" class="it.cedacri.io.junit.example.dto.FixedRecord">
 *             <field name="id" length="4" padding="0" justify="right"/>
 *             <field name="name" length="25" padding=" " justify="right" />
 *             <field name="surname" length="25" padding=" " justify="right" />
 *             <field name="date" length="8" format="ddMMyyy" />
 *         </record>
 *     </stream>
 *
 */


public class BeanIOStreamComposer implements FileComposer {

    private static final String headerPattern = "<stream name=\"%s\" format=\"fixedlength\">\n";
    private static final String recordPattern = "\t<record name=\"%s_RECORD\" class=\"%s\">\n";
    private static final String typeHandlerPattern = "\t<typeHandler name=\"%s\" class=\"%s\" />\n";
    private static final String defaultTrailer = "\t</record>\n</stream>";

    private List<String> header;
    private List<String> body;
    private String trailer;

    public BeanIOStreamComposer() {
        header = new ArrayList<>();
        body = new ArrayList<>();
    }

    /**
     * param0 - stream name
     * param1 - mapping class
     * @param params - parameters follow the schema above
     */
    @Override
    public void composeHeader(String... params) {
        header.add(String.format(headerPattern, params[0]));
        if (params.length > 2) {
            for (int i = 2; i < params.length; i++) {
                String[] typeHandlerConfigs = params[i].split(",");
                String typeHandlerName = typeHandlerConfigs[0];
                String typeHandlerClass = typeHandlerConfigs[1];
                header.add(String.format(typeHandlerPattern, typeHandlerName, typeHandlerClass));
            }
        }
        header.add(String.format(recordPattern, params[0], params[1]));
    }

    @Override
    public void composeTrailer(String... params) {
        this.trailer = defaultTrailer;
    }

    @Override
    public void composeBody(List<Field> fields) {
        long positionCounter = 0;

        for (Field field : fields) {
            body.add("\t\t" + field.getBeanIOLine() + String.format(" <!-- starts at: %d -->\n", positionCounter));
            positionCounter += parseFieldLength(field.getBeanIOLine());
        }
    }

    private long parseFieldLength(String line) {

        String[] tokens = line.split(" ");
        long result = 0;

        for (String token : tokens) {
            if (token.contains("length")) {
                StringBuilder numSeq = new StringBuilder();
                for (int i = token.indexOf("\"") + 1; i < token.length() && token.charAt(i) != '\"'; i++) {
                    numSeq.append(token.charAt(i));
                }

                result = Long.parseLong(numSeq.toString());
            }
        }

        return result;
    }

    @Override
    public void saveFile(String filepath) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(filepath));

        for (String str : header) {
            writer.write(str);
        }

        for (String str : body) {
            writer.write(str);
        }
        writer.write(trailer);
        writer.flush();

        writer.close();
    }
}
