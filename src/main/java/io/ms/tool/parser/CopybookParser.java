package io.ms.tool.parser;

import java.io.IOException;
import java.util.List;

/**
 * General interface for a copybook parser
 * This provides guideline for different types of parsers.
 */
public interface CopybookParser {

    List<RawField> parse(String filepath) throws IOException;

    ParserStats inspectParser();

}
