package io.ms.tool.copybookconverter.parser;

import io.ms.tool.copybookconverter.parser.model.RawField;
import io.ms.tool.copybookconverter.reader.CopybookReader;

import java.io.IOException;
import java.util.List;

/**
 * General interface for a copybook parser
 * This provides guideline for different types of parsers.
 */
public interface CopybookParser {

    List<RawField> parse(CopybookReader reader) throws IOException;

    ParserStats inspectParser();

}
