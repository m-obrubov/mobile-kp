package ru.obrubov.questionnaire.response.test;

import ru.obrubov.questionnaire.domain.Test;
import ru.obrubov.questionnaire.response.Response;

public class TestDataResponse extends Test implements Response {
    private TestDataResponse(Test test) {
        super();
        this.setId(test.getId());
        this.setName(test.getName());
        this.setAbout(test.getAbout());
        this.setRules(test.getRules());
        this.setQuestions(test.getQuestions());
        this.setAnswers(test.getAnswers());
        this.setResults(test.getResults());
    }

    public static TestDataResponse create(Test test) {
        return new TestDataResponse(test);
    }
}
