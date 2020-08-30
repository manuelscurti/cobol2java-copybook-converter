package io.ms.tool.junit;

import io.ms.tool.parser.CopybookParser;
import io.ms.tool.parser.RawField;
import io.ms.tool.parser.StandardParser;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ParsingTest {

    @Test
    public void commentsRemovalAndBasicParsing() throws IOException {
        CopybookParser parser = new StandardParser();
        List<RawField> rawFields = parser.parse("src/test/resources/AN000233_short.cpy");

        assertEquals(33, parser.inspectParser().getEffectiveFields());

    }

    @Test
    public void fillerDetectTest() throws IOException {
        CopybookParser parser = new StandardParser();
        List<RawField> rawFields = parser.parse("src/test/resources/AN000233_wFiller.cpy");

        for (RawField field : rawFields) {
            if (!field.isFiller()) {
                System.out.println(field);
            }
        }
        assertEquals(33, parser.inspectParser().getEffectiveFields());
    }

    @Test
    public void hierarchyPreservingTest() throws IOException {
        CopybookParser parser = new StandardParser();
        List<RawField> rawFields = parser.parse("src/test/resources/AN000233_hierarchy.cpy");

        for (RawField field : rawFields) {
            if (!field.isFiller()) {
                System.out.println(field);
            }
        }
    }

    /**
     * Used for development only
     */
    @Test
    public void lineParsingTest() throws IOException {
        CopybookParser parser = new StandardParser();
        List<RawField> rawFields = parser.parse("src/test/resources/single_line.cpy");

//        String[] tokens = new String[] {"CIAO:AN0233."};
//        if (tokens[tokens.length - 1].matches("[0-9a-zA-Z\\-.]*")) {
//            System.out.println("ok");
//        }

    }


}
