package io.ms.tool.copybookconverter.util;

import java.io.IOException;
import java.io.OutputStream;

public class JAXBPrinter extends OutputStream {
    StringBuilder strBuilder = new StringBuilder();

    @Override
    public void write(int b) throws IOException {
        strBuilder.append((char) b);
    }

    public String getString() {
        return strBuilder.toString();
    }

}
