package io.ms.tool.parser;

import java.util.ArrayList;
import java.util.List;

/**
 * Class representing the following patterns:
 * [level] [field-name].
 * [level] [field name] OCCURS [number of reps].
 *
 * e.g. 05  AN0233-AREAEL.
 */
public class GroupField extends RawField {

    List<RawField> subfields;
    Integer numberReps;

    public GroupField(String originalLine, Integer level, String name, String comment, Integer numberReps) {
        super(originalLine, level, name, comment);
        this.subfields = new ArrayList<>();
        this.numberReps = numberReps;
    }

    public GroupField(String originalLine, Integer level, String name, String comment) {
        this(originalLine, level, name, comment, 1);
    }

    public List<RawField> getSubfields() {
        return subfields;
    }

    public void insertSubfield(RawField subfield) {
        this.subfields.add(subfield);
    }

    public Integer getNumberReps() {
        return numberReps;
    }

    public void setNumberReps(Integer numberReps) {
        this.numberReps = numberReps;
    }
}
