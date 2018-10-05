package ru.obrubov.questionnaire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.TestResult;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.service.TestResultService;

@RestController
@RequestMapping("/result")
public class ResultController {

    private final TestResultService testResultService;

    @Autowired
    public ResultController(TestResultService testResultService) {
        this.testResultService = testResultService;
    }

    @PostMapping
    public Response addResult(@RequestBody TestResult testResult) {
        //TODO
        TestResult calculatedResult = testResultService.add(testResult);
        return null;
    }

    @GetMapping
    public Response getOwnResults() {
        //TODO
        return null;
    }

    @GetMapping("/all")
    public Response getAllResults() {
        //TODO
        return null;
    }
}
