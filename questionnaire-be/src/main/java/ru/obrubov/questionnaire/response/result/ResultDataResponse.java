package ru.obrubov.questionnaire.response.result;

import ru.obrubov.questionnaire.domain.TestResult;
import ru.obrubov.questionnaire.response.Response;

public class ResultDataResponse extends TestResult implements Response {

    private ResultDataResponse(TestResult testResult) {
        super();
        this.setId(testResult.getId());
        this.setPassedAt(testResult.getPassedAt());
        this.setUser(testResult.getUser());
        this.setTest(testResult.getTest());
        this.setResultCan(testResult.getResultCan());
        this.setQuestionResults(testResult.getQuestionResults());
        this.setQuestionResults(testResult.getQuestionResults());
    }

    public static ResultDataResponse create(TestResult testResult) {
        return new ResultDataResponse(testResult);
    }
}
