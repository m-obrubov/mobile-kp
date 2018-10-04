package ru.obrubov.questionnaire.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.TestDataAccess;
import ru.obrubov.questionnaire.domain.Test;

@Service
public class TestService {

    private final TestDataAccess testDataAccess;

    @Autowired
    public TestService(TestDataAccess testDataAccess) {
        this.testDataAccess = testDataAccess;
    }

    public Test create(Test test) {
        return testDataAccess.create(test);
    }

    public Test getTest() {
        return testDataAccess.getOne();
    }

    public boolean delete() {
        testDataAccess.delete();
        return testDataAccess.getOne() == null;
    }

}
