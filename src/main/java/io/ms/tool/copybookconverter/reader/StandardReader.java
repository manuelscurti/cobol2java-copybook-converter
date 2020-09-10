package io.ms.tool.copybookconverter.reader;

import org.apache.commons.lang3.StringUtils;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class StandardReader implements CopybookReader {

    private final BufferedReader reader;
    private static final int MAIN_COLUMN_START_INDEX = 7; //index starts from zero
    private static final int MAIN_COLUMN_END_INDEX = 71; //index starts from zero
    private static final int MAIN_COLUMN_LENGTH = 64;

    public StandardReader(String filePath) throws FileNotFoundException {
        this.reader = new BufferedReader(new FileReader(filePath));
    }

//    private String readLine(BufferedReader reader) throws IOException {
//        String _line0 = reader.readLine();
//
//        if (_line0 == null)
//            return null;
//
//        String _line1 = StringUtils.rightPad(_line0, 80, " ");
//
//        return _line1.substring(7, 72);
//    }





//    @Override
//    public String readNext() throws IOException {
//        StringBuilder line = new StringBuilder();
//
//        int _c;
//        boolean commentLine = false;
//        while ((_c = reader.read()) != -1) {
//            char c = (char) _c;
//            if (c == '.' && !commentLine) {
//                line.append('.');
//                break;
//            } else if (c == '*') {
//                commentLine = true;
//            } else if (c == '\n' && commentLine) {
//                break;
//            } else {
//                if (!commentLine) {
//                    if (c == '\n' || c == '\r') {
//                        line.append(" ");
//                    } else {
//                        line.append(c);
//                    }
//                }
//            }
//        }
//
//        String _line = line.toString();
//
//        if (_line.isEmpty()) {
//            return null;
//        }
//        return _line;
//    }

    @Override
    public String readNext() throws IOException {
        StringBuilder line = new StringBuilder();

        int i = 0;
        int _c;
        boolean commentedLine = false;
        boolean endLineFound = false;
        while ((_c = reader.read()) != -1 && !endLineFound) {
            char c = (char) _c;

            if (c == '*') {
                commentedLine = true;
            } else if (c == '\n') {
                continue;
            }

            if (!commentedLine) {
                if (i >= MAIN_COLUMN_START_INDEX && i <= MAIN_COLUMN_END_INDEX) {
                    //store characters when here
                    line.append(c);
                    if (c == '.') {
                        endLineFound = true;
                    }
                }
            }

            i++;
        }

        return null;
    }

    @Override
    public void close() throws IOException {
        reader.close();
    }
}
