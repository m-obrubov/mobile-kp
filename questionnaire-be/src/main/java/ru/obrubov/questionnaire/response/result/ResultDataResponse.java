package ru.obrubov.questionnaire.response.result;

import ru.obrubov.questionnaire.domain.Test;
import ru.obrubov.questionnaire.domain.TestResult;
import ru.obrubov.questionnaire.response.Response;

import java.util.HashSet;

public class ResultDataResponse extends TestResult implements Response {

    private ResultDataResponse(TestResult testResult) {
        super();
        this.setId(testResult.getId());
        this.setPassedAt(testResult.getPassedAt());
        this.setUser(testResult.getUser());
        Test test = testResult.getTest();
        test.setQuestions(new HashSet<>());
        test.setResults(new HashSet<>());
        test.setResults(new HashSet<>());
        testResult.setTest(test);
        this.setTest(testResult.getTest());
        this.setResultCan(testResult.getResultCan());
        this.setResultWant(testResult.getResultWant());
        this.setQuestionResults(testResult.getQuestionResults());
        this.setQuestionResults(testResult.getQuestionResults());
    }

    public static ResultDataResponse create(TestResult testResult) {
        return new ResultDataResponse(testResult);
    }
}
