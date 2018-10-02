package ru.obrubov.questionnaire.response.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import ru.obrubov.questionnaire.response.Response;

public class TokenResponse implements Response {
    private String token;

    private TokenResponse(String token) {
        this.token = token;
    }

    @JsonProperty("token")
    public String getToken() {
        return token;
    }

    public static TokenResponse create(String token) {
        return new TokenResponse(token);
    }
}
