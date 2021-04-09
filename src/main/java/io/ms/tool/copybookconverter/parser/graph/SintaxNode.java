package io.ms.tool.copybookconverter.parser.graph;

public class SintaxNode extends Node {

    private final String sintaxWord;

    public SintaxNode(String sintaxWord) {
        super(sintaxWord);
        this.sintaxWord = sintaxWord;
    }

    @Override
    public boolean match(String token) {
        return sintaxWord.toUpperCase().equals(token.toUpperCase());
    }
}
