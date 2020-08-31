package io.ms.tool.parser;

import java.util.List;

/**
 * Class representing the following pattern:
 * [level] [field name] PIC [type].
 * [level] FILLER PIC X([num]).
 *
 * e.g. 05  AN0233-AREAEL PIC X(5).
 */
public class PicField extends RawField {

    String typePattern;
    List<String> params;
    boolean isFiller;

    public PicField(String originalLine, Integer level, String name, String comment, String typePattern, List<String> params, boolean isFiller) {
        super(originalLine, level, name, comment);
        this.typePattern = typePattern;
        this.params = params;
        this.isFiller = isFiller;
    }

    public String getTypePattern() {
        return typePattern;
    }

    public void setTypePattern(String typePattern) {
        this.typePattern = typePattern;
    }

    public List<String> getParams() {
        return params;
    }

    public void setParams(List<String> params) {
        this.params = params;
    }

    public boolean isFiller() {
        return isFiller;
    }

    public void setFiller(boolean filler) {
        isFiller = filler;
    }
}
