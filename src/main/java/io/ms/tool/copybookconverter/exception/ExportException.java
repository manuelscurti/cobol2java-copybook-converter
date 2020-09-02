package io.ms.tool.copybookconverter.exception;

import io.ms.tool.copybookconverter.converter.xml.Field;

public class ExportException extends RuntimeException {

    Field failedField;

    public ExportException(String message, Field failedField) {
        super(message);
        this.failedField = failedField;
    }

    public Field getFailedField() {
        return failedField;
    }
}
