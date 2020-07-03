package io.ms.tool.core;

import java.math.BigDecimal;

public enum CobolType {
    COMP3V9_1("S9(%)V9(%) USAGE COMP-3", Comp3V9TypePattern.class),
    COMP3V9_2("S9(%)V9(%) COMP-3", Comp3V9TypePattern.class),
    COMP3V_1("S9(%)V USAGE COMP-3", Comp3VTypePattern.class),
    STRING_1("X(%)", StringTypePattern.class),
    NUMBER_1("9(%)", NumberTypePattern.class),
    BIGDECIMAL_1("-9.9(%)", BigDecimalTypePattern.class),
    BIGDECIMAL_2("9.9(%)", BigDecimalTypePattern.class);

    private String pattern;
    private Class<?> parser;

    CobolType(String pattern, Class<?> parser) {
        this.parser = parser;
        this.pattern = pattern;
    }

    public String getPattern() {
        return pattern;
    }

    public Class<?> getParser() {
        return parser;
    }
}
