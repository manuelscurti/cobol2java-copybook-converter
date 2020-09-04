package io.ms.tool.copybookconverter.typepattern;

import java.util.List;

public interface TypePattern {

    void setup(String name, List<String> params);

    int getFieldLength();

}
