package io.ms.tool.copybookconverter.parser;

import io.ms.tool.copybookconverter.parser.model.RawField;

public class ParsingException extends RuntimeException {

    RawField rawField;

    public ParsingException(String message, RawField rawField) {
        super(message);
        this.rawField = rawField;
    }

    public ParsingException(String message, Throwable cause, RawField rawField) {
        super(message, cause);
        this.rawField = rawField;
    }

    public RawField getRawField() {
        return rawField;
    }
}
