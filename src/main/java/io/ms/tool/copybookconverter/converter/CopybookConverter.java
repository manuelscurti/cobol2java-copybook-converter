package io.ms.tool.copybookconverter.converter;

import io.ms.tool.copybookconverter.export.CopybookExport;
import io.ms.tool.copybookconverter.parser.model.RawField;

import java.util.List;

/**
 * Conversion works in three steps, this is the second step.
 * In this step, the already parsed copybook is converted into an internal XML representation format
 * This format can then be used to be exported into various languages (Java, BeanIO XML at the moment)
 */
public interface CopybookConverter {

    /**
     * Converts the list of fields into the intermediate representation XML
     * @param fields - list of fields parsed by CopybookParser
     * @param copybookName - name of the copybook
     * @return the XML of the intermediate representation
     */
    String convert(List<RawField> fields, String copybookName);

    /**
     * Exports the intermediate XML to a usable format such as Java classes and/or BeanIO XML streams
     * @param exporter - XML exporter, a class instance which implements the CopybookExport interface
     * @param xmlCopybook - string containing the xml intermediate representation of the copybook
     * @return resulting string depends on the chosen export
     */
    String exportTo(CopybookExport exporter, String xmlCopybook);

}
