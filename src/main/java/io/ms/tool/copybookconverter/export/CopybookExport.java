package io.ms.tool.copybookconverter.export;

import java.io.InputStream;
import java.io.OutputStream;

public interface CopybookExport {

    void export(InputStream xmlCopybook, OutputStream out);

}
