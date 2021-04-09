package io.ms.tool.copybookconverter;

import io.ms.tool.copybookconverter.export.beanio.model.*;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class XmlTest {

    @Test
    public void testBeanXml() throws JAXBException {
        List<BeanItem> items = new ArrayList<>();

        BeanField fieldA = new BeanField("fieldA", 10, null, null, null, null, null, null);
        BeanField fieldB = new BeanField("fieldB", 10, null,null, null, null, null, null);
        BeanField fieldC = new BeanField("fieldC", 10, null,null, null, null, null, null);

        items.add(fieldA);
        items.add(fieldB);
        items.add(fieldC);

        List<BeanItem> segmentFields = new ArrayList<>();
        segmentFields.add(new BeanField("fieldA_A", 10, null,null, null, null, null, null));
        segmentFields.add(new BeanField("fieldA_B", 10, null,null, null, null, null, null));
        segmentFields.add(new BeanField("fieldA_C", 10, null,null, null, null, null, null));

        BeanSegment segment = new BeanSegment("segmentA", "list", 0, 4, "it.cedacri.segmentb", segmentFields);

        items.add(segment);

        BeanRecord record = new BeanRecord("TEST_RECORD", "it.cedacri", items);
        List<BeanRecord> records = new ArrayList<>();
        records.add(record);

        BeanStream stream = new BeanStream("TEST_STREAM", "fixedlength", records);

        JAXBContext jaxbContext = JAXBContext.newInstance(BeanStream.class);
        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        jaxbMarshaller.marshal(stream, System.out);

    }


}
