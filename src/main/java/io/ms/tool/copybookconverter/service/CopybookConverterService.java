package io.ms.tool.copybookconverter.service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CopybookConverterService {

    @GetMapping("/greeting")
    public ConversionRequest conversionRequest(@RequestParam(value = "copybookName", defaultValue = "Untitled") String copybookName, @RequestParam(value = "packagePath", defaultValue = "org.untitled.") String packagePath) {
        return new ConversionRequest(copybookName, packagePath);
    }



}
