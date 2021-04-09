package io.ms.tool.copybookconverter.parser.graph;

public class SintaxGraph {

    private final Node startPoint;

    public SintaxGraph(Node startPoint) {
        this.startPoint = startPoint;
    }

    public void traverse(String[] tokens) {
        int i = 0;
        for (String token : tokens) {
            if (startPoint.match(token)) {
                traverse(startPoint, tokens, i + 1);
            }
        }



    }

    private void traverse(Node startPoint, String[] tokens, int i) {
        if (i >= tokens.length)
            return;

        for (Node pattern : startPoint.getNodes()) {
            if (pattern.match(tokens[i])) {
                System.out.println(startPoint);
            }
        }

        
    }

}
