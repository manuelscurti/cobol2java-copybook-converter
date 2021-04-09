package io.ms.tool.copybookconverter.exception;

public class UnmarshallException extends RuntimeException {

    String originalData;

    public UnmarshallException(String message, String originalData) {
        super(message);
        this.originalData = originalData;
    }

    public String getOriginalData() {
        return originalData;
    }
}
