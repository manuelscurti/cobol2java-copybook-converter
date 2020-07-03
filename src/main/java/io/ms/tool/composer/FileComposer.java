package io.ms.tool.composer;

import io.ms.tool.converter.Field;

import java.io.IOException;
import java.util.List;

public interface FileComposer {

    void composeHeader(String... params);
    void composeTrailer(String... params);
    void composeBody(List<Field> fields);

    void saveFile(String filepath) throws IOException;

}
