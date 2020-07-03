package io.ms.tool.core;

import java.util.List;

public interface TypePattern {

    void setup(String name, List<String> params);
    String getBeanIOMap();
    String getJavaProperty();

}
