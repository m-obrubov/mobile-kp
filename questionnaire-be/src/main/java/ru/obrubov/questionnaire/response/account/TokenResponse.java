package ru.obrubov.questionnaire.response.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import ru.obrubov.questionnaire.response.Response;

public class TokenResponse implements Response {
    private Token token;


    private TokenResponse(Token token) {
        this.token = token;
    }

    public static TokenResponse create(Token token) {
        return new TokenResponse(token);
    }

    @JsonProperty("token")
    public Token getToken() {
        return token;
    }
}
