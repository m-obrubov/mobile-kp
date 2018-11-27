package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.TestRepository;
import ru.obrubov.questionnaire.domain.Test;

@Service
public class TestDataAccess {

    private final TestRepository testRepository;

    @Autowired
    public TestDataAccess(TestRepository testRepository) {
        this.testRepository = testRepository;
    }

    public Test create(Test test) {
        return testRepository.save(test);
    }

    public Test getOne() {
        return testRepository.getOne();
    }

    public Test update(Test test) {
        return testRepository.save(test);
    }
}
