package ru.obrubov.questionnaire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.TestResult;
import ru.obrubov.questionnaire.exception.test.TestNotFoundException;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.result.ResultDataResponse;
import ru.obrubov.questionnaire.service.TestResultService;

import javax.validation.constraints.NotNull;

@RestController
@RequestMapping("/result")
public class ResultController {

    private final TestResultService testResultService;

    @Autowired
    public ResultController(TestResultService testResultService) {
        this.testResultService = testResultService;
    }

    @PostMapping
    public ResultDataResponse addResult(@RequestBody @NotNull TestResult testResult) {
        try {
            TestResult calculatedResult = testResultService.add(testResult);
            return ResultDataResponse.create(calculatedResult);
        } catch (TestNotFoundException e) {
            ErrorResponse.create(400);//TODO
            e.printStackTrace();
        }
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
