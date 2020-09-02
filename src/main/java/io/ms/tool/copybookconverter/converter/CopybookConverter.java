package io.ms.tool.copybookconverter.converter;

import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.parser.model.RawField;

import java.util.List;

public interface CopybookConverter {

    String convert(List<RawField> fields, String copybookName);

    String exportTo(CopybookExport exporter, String xmlCopybook);

}
