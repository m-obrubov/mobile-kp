package ru.obrubov.questionnaire.response.result;

import com.fasterxml.jackson.annotation.JsonProperty;
import ru.obrubov.questionnaire.domain.TestResult;
import ru.obrubov.questionnaire.response.Response;

import java.util.ArrayList;
import java.util.List;

public class ResultsDataResponse implements Response {

    private List<ResultDataResponse> results;

    private ResultsDataResponse(List<TestResult> testResultList) {
        super();
        results = new ArrayList<>();
        for (TestResult testResult: testResultList) {
            this.results.add(ResultDataResponse.create(testResult));
        }
    }

    public static ResultsDataResponse create(List<TestResult> testResultList) {
        return new ResultsDataResponse(testResultList);
    }

    @JsonProperty("results") //TODO -  наменование неизвестно
    public List<ResultDataResponse> getResults() {
        return results;
    }
}
