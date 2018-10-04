package ru.obrubov.questionnaire.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ErrorResponse implements Response {
    private String status;
    private int errorCode;

    private ErrorResponse(int errorCode) {
        this.status = "error";
        this.errorCode = errorCode;
    }

    @JsonProperty("status")
    public String getStatus() {
        return status;
    }

    @JsonProperty("code")
    public int getErrorCode() {
        return errorCode;
    }

    public static ErrorResponse create(int errorCode) {
        return new ErrorResponse(errorCode);
    }
}
