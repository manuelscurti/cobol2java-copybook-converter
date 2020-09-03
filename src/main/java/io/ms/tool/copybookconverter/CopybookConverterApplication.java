package io.ms.tool.copybookconverter;

import io.ms.tool.copybookconverter.converter.CopybookConverter;
import io.ms.tool.copybookconverter.converter.StandardConverter;
import io.ms.tool.copybookconverter.export.beanio.BeanIOExport;
import io.ms.tool.copybookconverter.export.java.JavaExport;
import io.ms.tool.copybookconverter.parser.CopybookParser;
import io.ms.tool.copybookconverter.parser.StandardParser;
import io.ms.tool.copybookconverter.parser.model.RawField;
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
			JavaExport javaExporter = event.getApplicationContext().getBean(JavaExport.class);
			BeanIOExport beanIOExporter = event.getApplicationContext().getBean(BeanIOExport.class);

			try {
				List<RawField> rawFields = parser.parse("src/main/resources/AN000233_hierarchy.cpy");
				String xmlCopybook = converter.convert(rawFields, "AN000233");

				String javaClasses = javaExporter.export(xmlCopybook);
				String beanIOstream = beanIOExporter.export(xmlCopybook);

				System.out.println(javaClasses);
				System.out.println("\n"+beanIOstream);

			} catch (IOException e) {
				e.printStackTrace();
			}

		});
	}

}
