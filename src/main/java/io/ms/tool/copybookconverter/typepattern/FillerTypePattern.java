package io.ms.tool.copybookconverter.typepattern;

import io.ms.tool.copybookconverter.export.beanio.IBeanIOExport;
import io.ms.tool.copybookconverter.export.beanio.model.BeanField;

import java.util.List;

public class FillerTypePattern implements TypePattern, IBeanIOExport {
    private String name;
    private Integer length;
    private static final int NUM_REQUIRED_PARAMS = 1;

    @Override
    public void setup(String name, List<String> params) {
        if (params.size() != NUM_REQUIRED_PARAMS) {
            throw new UnsupportedOperationException("StringTypePattern must receive 1 parameter");
        }

        this.name = name;
        this.length = Integer.parseInt(params.get(0));
    }

    @Override
    public int getFieldLength() {
        return length;
    }

    @Override
    public BeanField getBeanIOField() {
        return new BeanField(name, length, null, null, "true", null, null);
    }
}
