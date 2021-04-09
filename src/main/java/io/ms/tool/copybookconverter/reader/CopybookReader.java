package io.ms.tool.copybookconverter.reader;

import java.io.IOException;

public interface CopybookReader  {

    String readNext() throws IOException;

    void close() throws IOException;

}
