package io.ms.tool.util;

public class CobolUtils {

    /**
     * Check if the given field is commented
     * It works by looking at the position of the '*' character (if any) and if it is before the PIC instruction then the
     * line is commented
     * @param line - line to check
     * @return true if line is commented
     */
    public static boolean isLineCommented(String line) {
        int posCommentChar = line.indexOf("*");
        int posPicBlock = line.indexOf("PIC");

        return posCommentChar != -1 && posCommentChar < posPicBlock;
    }

    public static boolean isFiller(String line) {
        return line.toUpperCase().contains("FILLER");
    }

    public static boolean containsFieldSpecs(String line) {
        return line.toUpperCase().contains("PIC");
    }

}
