package ru.obrubov.questionnaire.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix="questionnaire")
public class QuestionnaireConfig {
    private int tokenExpireDays;

    public int getTokenExpireDays() {
        return tokenExpireDays;
    }

    public void setTokenExpireDays(int tokenExpireDays) {
        this.tokenExpireDays = tokenExpireDays;
    }
}
