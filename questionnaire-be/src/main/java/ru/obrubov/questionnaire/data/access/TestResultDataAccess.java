package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.TestResultRepository;
import ru.obrubov.questionnaire.domain.TestResult;

import java.util.Collections;
import java.util.List;

@Service
public class TestResultDataAccess {
    private final TestResultRepository testResultRepository;

    @Autowired
    public TestResultDataAccess(TestResultRepository testResultRepository) {
        this.testResultRepository = testResultRepository;
    }

    public TestResult create(TestResult testResult) {
        return testResultRepository.save(testResult);
    }

    public List<TestResult> getByUserId(Long id){ // получение результатов теста пользователя
        List<TestResult> results = testResultRepository.getAllByUserId(id);
        return results != null ? results : Collections.emptyList();
    }

    public List<TestResult> getAll(){
        return testResultRepository.findAll();
    }
}
