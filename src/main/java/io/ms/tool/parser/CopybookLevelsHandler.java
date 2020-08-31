package io.ms.tool.parser;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class CopybookLevelsHandler {

    private Stack<List<RawField>> fieldsStack;
    private RawField lastAddedField;

    public CopybookLevelsHandler() {
        fieldsStack = new Stack<>();
        List<RawField> rawFields = new ArrayList<>();
        fieldsStack.push(rawFields);
        lastAddedField = null;
    }

    private void levelUp(RawField rawField) {
        ((GroupField) lastAddedField).insertSubfield(rawField);
        fieldsStack.push(((GroupField) lastAddedField).getSubfields());
    }

    private void levelDown(RawField rawField) {
        List<RawField> currentFieldList = fieldsStack.pop(); //removes current level

        //seeks the fields list with the same level of the field being added
        while (rawField.getLevel() < currentFieldList.get(0).getLevel()) {
            currentFieldList = fieldsStack.pop();
        }

        currentFieldList.add(rawField);
        fieldsStack.push(currentFieldList);
    }

    private void addFieldToCurrentLevel(RawField rawField) {
        List<RawField> currentFieldList = fieldsStack.pop();
        currentFieldList.add(rawField);
        fieldsStack.push(currentFieldList);
    }

    /**
     * Insert field in the current hierarchy level
     */
    public void addField(RawField rawField) {
        if (lastAddedField == null) {
            //init first level
            addFieldToCurrentLevel(rawField);
        } else {
            if ((lastAddedField instanceof GroupField) && rawField.getLevel() > lastAddedField.getLevel()) {
                //going deep
                levelUp(rawField);
            } else if (rawField.getLevel() < lastAddedField.getLevel()) {
                //going up
                levelDown(rawField);
            } else if (rawField.getLevel().equals(lastAddedField.getLevel())) {
                //same level
                addFieldToCurrentLevel(rawField);
            } else {
                throw new ParsingException(String.format("Error while parsing %s", rawField.getOriginalLine()), rawField);
            }
        }

        this.lastAddedField = rawField;
    }




}
