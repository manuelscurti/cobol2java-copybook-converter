package io.ms.tool.copybookconverter.parser.graph;

import java.util.regex.Pattern;

public class TokenNode extends Node {

    private final Pattern semanticRule;

    public TokenNode(String name, String semanticRule) {
        super(name);
        this.semanticRule = Pattern.compile(semanticRule);
    }

    @Override
    public boolean match(String token) {
        return semanticRule.matcher(token).matches();
    }
}
