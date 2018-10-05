package ru.obrubov.questionnaire.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.TestResultDataAccess;
import ru.obrubov.questionnaire.domain.TestResult;

@Service
public class TestResultService {
    private final TestResultDataAccess testResultDataAccess;

    @Autowired
    public TestResultService(TestResultDataAccess testResultDataAccess) {
        this.testResultDataAccess = testResultDataAccess;
    }

    public TestResult add(TestResult testResult) {
        //TODO рассчитать все необходимые поля
        return testResultDataAccess.create(testResult);
    }
}
