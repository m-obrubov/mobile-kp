package ru.obrubov.questionnaire.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ErrorResponse implements Response {
    private String message;

    private ErrorResponse(String message) {
        this.message = message;
    }

    public static ErrorResponse create(String message) {
        return new ErrorResponse(message);
    }

    @JsonProperty("message")
    public String getMessage() {
        return message;
    }
}
