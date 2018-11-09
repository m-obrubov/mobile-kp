package ru.obrubov.questionnaire.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.domain.Test;
import ru.obrubov.questionnaire.exception.init.AlreadyInitializedException;
import ru.obrubov.questionnaire.exception.init.InitializationException;

import java.io.IOException;

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

    public void init() throws AlreadyInitializedException, InitializationException {
        if(testService.getTest() != null) {
            throw new AlreadyInitializedException();
        }
        Test test;
        try {
            Resource jsonResource = new ClassPathResource("json/test.json");
            test = objectMapper.readValue(jsonResource.getInputStream(), Test.class);
        } catch (IOException e) {
            throw new InitializationException("Ошибка чтения JSON", e);
        }
        if(testService.create(test) == null) {
            throw new InitializationException("Тест не создан");
        }
    }
}
