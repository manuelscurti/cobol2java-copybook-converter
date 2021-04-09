package io.ms.tool.copybookconverter.exception;

import io.ms.tool.copybookconverter.converter.xml.Copybook;

public class MarshalException extends RuntimeException {

    Copybook copybook;

    public MarshalException(String message, Copybook copybook) {
        super(message);
        this.copybook = copybook;
    }

    public Copybook getCopybook() {
        return copybook;
    }
}
