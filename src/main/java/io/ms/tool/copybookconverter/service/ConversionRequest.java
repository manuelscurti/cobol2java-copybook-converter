package io.ms.tool.copybookconverter.service;

public class ConversionRequest {

    private String copybookName;
    private String packagePath;

    public ConversionRequest(String copybookName, String packagePath) {
        this.copybookName = copybookName;
        this.packagePath = packagePath;
    }

    public String getCopybookName() {
        return copybookName;
    }

    public void setCopybookName(String copybookName) {
        this.copybookName = copybookName;
    }

    public String getPackagePath() {
        return packagePath;
    }

    public void setPackagePath(String packagePath) {
        this.packagePath = packagePath;
    }
}
