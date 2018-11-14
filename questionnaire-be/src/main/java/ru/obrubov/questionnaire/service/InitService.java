package ru.obrubov.questionnaire.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.domain.Test;
import ru.obrubov.questionnaire.exception.init.InitializationException;

import javax.annotation.PostConstruct;

@Service
public class InitService {

    private final TestService testService;
    private final ObjectMapper objectMapper;

    @Autowired
    public InitService(TestService testService,
                       ObjectMapper objectMapper) {
        this.testService = testService;
        this.objectMapper = objectMapper;
    }

    @PostConstruct
    public void init() throws Exception {
        Test savedTest = testService.getTest();

        Resource jsonResource = new ClassPathResource("json/test.json");
        Test jsonTest = objectMapper.readValue(jsonResource.getInputStream(), Test.class);

        if(savedTest == null) {
            Test createdTest = testService.create(jsonTest);
            if(createdTest == null) {
                throw new InitializationException("Тест не был создан");
            }
            return;
        }
        if(!savedTest.equals(jsonTest)) {
            Test updatedTest = testService.update(jsonTest);
            if(updatedTest == null) {
                throw new InitializationException("Тест не был обновлен");
            }
        }
    }
}
