package io.ms.tool.copybookconverter.parser;

import io.ms.tool.copybookconverter.parser.graph.Node;
import io.ms.tool.copybookconverter.parser.graph.SintaxGraph;
import io.ms.tool.copybookconverter.parser.graph.SintaxNode;
import io.ms.tool.copybookconverter.parser.graph.TokenNode;
import io.ms.tool.copybookconverter.parser.model.RawField;
import io.ms.tool.copybookconverter.reader.CopybookReader;

import java.io.IOException;
import java.util.List;

public class GraphParser implements CopybookParser {

    private SintaxGraph graph;

    public GraphParser() {

        Node level = new TokenNode("<level>", "[0-9]*");
        Node fieldname = new TokenNode("<fieldname>", "^\\w+(\\.\\w+)*$");
        Node end = new SintaxNode(".");
        Node occurs = new SintaxNode("OCCURS");
        Node pic = new SintaxNode("PIC");
        Node type = new TokenNode("<type>", "");
        Node numreps = new TokenNode("<nreps>", "[0-9]*");
        Node minreps = new TokenNode("<minreps>", "[0-9]*");
        Node to = new SintaxNode("TO");
        Node maxreps = new TokenNode("<maxreps>", "[0-9]*");
        Node dependingon = new SintaxNode("DEPENDING ON");
        Node fieldnameref = new TokenNode("<fieldnameref>", "^\\w+(\\.\\w+)*$");
        Node value = new SintaxNode("VALUE");
        Node zeroes = new SintaxNode("ZEROES");
        Node spaces = new SintaxNode("SPACES");
        Node defaultval = new TokenNode("<defaultvalue>", "");

        //building sintax graph
        level.insertNode(fieldname);
        fieldname.insertNode(end);
        fieldname.insertNode(occurs);
        fieldname.insertNode(pic);
        occurs.insertNode(numreps);
        numreps.insertNode(pic);
        numreps.insertNode(minreps);
        numreps.insertNode(end);
        minreps.insertNode(to);
        to.insertNode(maxreps);
        maxreps.insertNode(dependingon);
        dependingon.insertNode(fieldnameref);
        fieldnameref.insertNode(end);
        pic.insertNode(type);
        type.insertNode(end);
        type.insertNode(value);
        type.insertNode(zeroes);
        type.insertNode(spaces);
        type.insertNode(defaultval);
        zeroes.insertNode(end);
        spaces.insertNode(end);
        defaultval.insertNode(end);

    }

    @Override
    public List<RawField> parse(CopybookReader reader) throws IOException {
        return null;
    }

    @Override
    public ParserStats inspectParser() {
        return null;
    }



}
