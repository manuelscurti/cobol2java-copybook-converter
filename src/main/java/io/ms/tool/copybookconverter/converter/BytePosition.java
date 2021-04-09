package io.ms.tool.copybookconverter.converter;

public class BytePosition {

    Integer currentBytePosition;

    public BytePosition() {
        this.currentBytePosition = 1;
    }

    public void move(Integer displacement) {
        currentBytePosition += displacement;
    }

    public Integer get() {
        return currentBytePosition;
    }


}
