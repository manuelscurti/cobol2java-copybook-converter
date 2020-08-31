package io.ms.tool.copybookconverter.converter;

import io.ms.tool.copybookconverter.converter.xml.Copybook;
import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.parser.model.RawField;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

public interface CopybookConverter {

    Copybook convert(List<RawField> fields, OutputStream outputXml, String copybookName);

    void exportTo(CopybookExport exporter, InputStream xmlCopybook, OutputStream outputFolder);

}
