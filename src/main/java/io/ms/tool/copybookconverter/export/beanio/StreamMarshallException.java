package io.ms.tool.copybookconverter.export.beanio;

import io.ms.tool.copybookconverter.export.beanio.model.BeanStream;

public class StreamMarshallException extends RuntimeException {

    BeanStream stream;

    public StreamMarshallException(String message, BeanStream stream) {
        super(message);
        this.stream = stream;
    }

    public BeanStream getStream() {
        return stream;
    }
}
