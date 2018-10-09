package ru.obrubov.questionnaire.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.TestResult;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.exception.test.TestNotFoundException;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.result.ResultDataResponse;
import ru.obrubov.questionnaire.response.result.ResultsDataResponse;
import ru.obrubov.questionnaire.security.AccessResolver;
import ru.obrubov.questionnaire.service.TestResultService;

import javax.validation.constraints.NotNull;

@RestController
@RequestMapping("/result")
public class ResultController {

    private final Logger logger = LoggerFactory.getLogger(ResultController.class);

    private final TestResultService testResultService;
    private final AccessResolver accessResolver;

    @Autowired
    public ResultController(TestResultService testResultService,
                            AccessResolver accessResolver) {
        this.testResultService = testResultService;
        this.accessResolver = accessResolver;
    }

    @PostMapping
    public Response addResult(@RequestBody @NotNull TestResult testResult) {
        try {
            User user = accessResolver.getCurrentUser();
            TestResult calculatedResult = testResultService.add(testResult,user);
            return ResultDataResponse.create(calculatedResult);
        } catch (TestNotFoundException e) {
            logger.error(e.getMessage());
            return ErrorResponse.create(1002);
        }
    }

    @GetMapping
    public Response getOwnResults() {
        User user = accessResolver.getCurrentUser();
        return ResultsDataResponse.create(testResultService.getOwnResults(user.getId()));
    }

    @GetMapping("/all")
    public Response getAllResults() {
        return ResultsDataResponse.create(testResultService.getAll());
    }
}
