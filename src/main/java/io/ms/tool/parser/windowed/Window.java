package io.ms.tool.parser.windowed;

import java.util.ArrayList;
import java.util.List;

public class Window {

    List<String> lines;
    int numFields;

    public Window() {
        lines = new ArrayList<>();
    }

    public void add(String line) {
        lines.add(line);
    }



}
