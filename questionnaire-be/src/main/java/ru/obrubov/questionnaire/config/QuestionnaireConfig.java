package ru.obrubov.questionnaire.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix="questionnaire")
public class QuestionnaireConfig {
    private int tokenExpireMinutes;
    private String tokenSecretKey;

    public int getTokenExpireMinutes() {
        return tokenExpireMinutes;
    }

    public void setTokenExpireMinutes(int tokenExpireMinutes) {
        this.tokenExpireMinutes = tokenExpireMinutes;
    }

    public String getTokenSecretKey() {
        return tokenSecretKey;
    }

    public void setTokenSecretKey(String tokenSecretKey) {
        this.tokenSecretKey = tokenSecretKey;
    }
}
