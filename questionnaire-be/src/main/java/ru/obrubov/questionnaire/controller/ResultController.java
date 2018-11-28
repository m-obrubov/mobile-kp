package ru.obrubov.questionnaire.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.Gender;
import ru.obrubov.questionnaire.domain.TestResult;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.exception.test.TestNotFoundException;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.result.ResultDataResponse;
import ru.obrubov.questionnaire.response.result.ResultsDataResponse;
import ru.obrubov.questionnaire.security.AccessResolver;
import ru.obrubov.questionnaire.service.TestResultFilter;
import ru.obrubov.questionnaire.service.TestResultService;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

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
    public ResponseEntity<Response> addResult(@RequestBody @NotNull TestResult testResult) {
        try {
            User user = accessResolver.getCurrentUser();
            TestResult calculatedResult = testResultService.add(testResult,user);
            return ResponseEntity.ok(ResultDataResponse.create(calculatedResult));
        } catch (TestNotFoundException e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body(ErrorResponse.create("Неизвестная ошибка. Обратитесь в службу поддержки."));
        }
    }

    @GetMapping
    public ResponseEntity<Response> getOwnResults() {
        User user = accessResolver.getCurrentUser();
        return ResponseEntity.ok(ResultsDataResponse.create(testResultService.getOwnResults(user.getId())));
    }

    @GetMapping("/all")
    public ResponseEntity<Response> getAllResults(@RequestParam(value = TestResultFilter.DATE_FROM, required = false) LocalDateTime dateFrom,
                                  @RequestParam(value = TestResultFilter.DATE_TO, required = false) LocalDateTime dateTo,
                                  @RequestParam(value = TestResultFilter.GENDER, required = false) Gender gender,
                                  @RequestParam(value = TestResultFilter.CITY, required = false) String city,
                                  @RequestParam(value = TestResultFilter.AGE_FROM, required = false) Integer ageFrom,
                                  @RequestParam(value = TestResultFilter.AGE_TO, required = false) Integer ageTo) {
        Map<String, Object> filter = new HashMap<>();
        filter.put(TestResultFilter.DATE_FROM, dateFrom);
        filter.put(TestResultFilter.DATE_TO, dateTo);
        filter.put(TestResultFilter.GENDER, gender);
        filter.put(TestResultFilter.CITY, city);
        filter.put(TestResultFilter.AGE_FROM, ageFrom);
        filter.put(TestResultFilter.AGE_TO, ageTo);
        return ResponseEntity.ok(ResultsDataResponse.create(testResultService.getByFilter(filter)));
    }
}
