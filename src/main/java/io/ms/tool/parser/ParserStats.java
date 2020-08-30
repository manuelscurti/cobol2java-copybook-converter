package io.ms.tool.parser;

import java.util.ArrayList;
import java.util.List;

public class ParserStats {

    int numDetectedFields;
    int numFillerFields;
    List<String> discardedLines;

    public ParserStats() {
        this.discardedLines = new ArrayList<>();
    }

    public int getEffectiveFields() {
        return numDetectedFields - numFillerFields;
    }

    public int getTotalDetectedFields() {
        return numDetectedFields;
    }

    public void newDetectedFields() {
        this.numDetectedFields += 1;
    }

    public int getNumFillerFields() {
        return numFillerFields;
    }

    public void newFillerField() {
        this.numFillerFields += 1;
    }

    public List<String> getDiscardedLines() {
        return discardedLines;
    }

    public void insertDiscardedLine(String line) {
        this.discardedLines.add(line);
    }

    @Override
    public String toString() {
        return "ParserStats{" +
                "numDetectedFields=" + numDetectedFields +
                ", numFillerFields=" + numFillerFields +
                ", discardedLines=[" + discardedLines +
                "]}";
    }
}
