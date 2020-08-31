package io.ms.tool.copybookconverter;

import io.ms.tool.copybookconverter.converter.CopybookConverter;
import io.ms.tool.copybookconverter.converter.StandardConverter;
import io.ms.tool.copybookconverter.parser.CopybookParser;
import io.ms.tool.copybookconverter.parser.model.RawField;
import io.ms.tool.copybookconverter.parser.StandardParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;

import java.io.IOException;
import java.util.List;

@SpringBootApplication
public class CopybookConverterApplication {
	private static final Logger log = LoggerFactory.getLogger(CopybookConverterApplication.class);

	public static void main(String[] args) {
		SpringApplication springApplication = new SpringApplication(CopybookConverterApplication.class);
		addInitHooks(springApplication);

		springApplication.run(args);
	}

	static void addInitHooks(SpringApplication application) {
		application.addListeners((ApplicationListener<ApplicationReadyEvent>) event -> {
			CopybookParser parser = event.getApplicationContext().getBean(StandardParser.class);
			CopybookConverter converter = event.getApplicationContext().getBean(StandardConverter.class);

			try {
				List<RawField> rawFields = parser.parse("src/main/resources/specific_test.cpy");
				converter.convert(rawFields, null, "AN000233");

			} catch (IOException e) {
				e.printStackTrace();
			}

//			List<Field> fields = new ArrayList<>();
//			Field field = new Field();
//			field.setName("fieldTest");
//			field.setDefinition("X(%)");
//			fields.add(field);
//
//			List<Field> fieldsB = new ArrayList<>();
//			Field fieldB = new Field();
//			fieldB.setName("fieldTest");
//			fieldB.setDefinition("X(%)");
//			fieldsB.add(field);
//
//			List<Level> levels = new ArrayList<>();
//			Level level5 = new Level();
//			level5.setId(5);
//			level5.setName("TEST");
//			level5.setField(fields);
//
//			Level level10 = new Level();
//			level10.setField(fieldsB);
//			level10.setId(10);
//			level10.setName("BTEST");
//			level10.setOccurs(11);
//
//			List<Level> fiveSubLevels = new ArrayList<>();
//			fiveSubLevels.add(level10);
//			level5.setLevel(fiveSubLevels);
//
//			levels.add(level5);
//
//			Copybook copybook = new Copybook();
//			copybook.setLevels(levels);
//
//			try {
//				JAXBContext jaxbContext = JAXBContext.newInstance(Copybook.class);
//				Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
//				jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
////				jaxbMarshaller.marshal(copybook, new File( "country.xml" ) );
//				jaxbMarshaller.marshal(copybook, System.out);
//			} catch (JAXBException e) {
//				e.printStackTrace();
//			}

		});
	}

}
