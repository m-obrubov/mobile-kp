package ru.obrubov.questionnaire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.Test;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.OkResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.test.TestDataResponse;
import ru.obrubov.questionnaire.service.TestService;

@RestController
@RequestMapping("/test")
public class TestController {

    private final TestService testService;

    @Autowired
    public TestController(TestService testService) {
        this.testService = testService;
    }

    @GetMapping
    public Response getOne() {
        Test test = testService.getTest();
        if(test == null) {
            return ErrorResponse.create(500);
        }
        return TestDataResponse.create(test);
    }

    @PostMapping
    public Response add(@RequestBody Test test) {
        Test createdTest = testService.create(test);
        if(createdTest == null) {
            return ErrorResponse.create(500);
        }
        return OkResponse.create();
    }

    @DeleteMapping
    public Response delete() {
        boolean isDeleted = testService.delete();
        return isDeleted ? OkResponse.create() : ErrorResponse.create(500);
    }
}