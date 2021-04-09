package io.ms.tool.copybookconverter;

import io.ms.tool.copybookconverter.reader.CopybookReader;
import io.ms.tool.copybookconverter.reader.StandardReader;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

@SpringBootTest
public class CopybookReaderTest {

    @Test
    public void readTest() throws IOException {
        CopybookReader reader = new StandardReader("src/main/resources/FAXC0001.cpy");

        String line;
        while ((line = reader.readNext()) != null) {
            System.out.println(line);
        }
    }
}
