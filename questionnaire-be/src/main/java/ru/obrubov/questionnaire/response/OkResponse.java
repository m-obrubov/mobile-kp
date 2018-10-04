package ru.obrubov.questionnaire.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public class OkResponse implements Response {
    private String status;

    private OkResponse() {
        this.status = "ok";
    }

    @JsonProperty("status")
    public String getStatus() {
        return status;
    }

    public static OkResponse create() {
        return new OkResponse();
    }
}
