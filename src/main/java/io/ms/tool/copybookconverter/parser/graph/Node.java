package io.ms.tool.copybookconverter.parser.graph;

import java.util.ArrayList;
import java.util.List;

public abstract class Node implements PatternMatcher {

    private final String name;
    private final List<Node> nodes;

    public Node(String name) {
        this.name = name;
        this.nodes = new ArrayList<>();
    }

    public void insertNode(Node node) {
        nodes.add(node);
    }

    public List<Node> getNodes() {
        return nodes;
    }

    @Override
    public String toString() {
        return "Node{" +
                "name='" + name + '\'' +
                '}';
    }
}
