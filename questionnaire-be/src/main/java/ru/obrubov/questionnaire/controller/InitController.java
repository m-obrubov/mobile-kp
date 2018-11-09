package ru.obrubov.questionnaire.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.obrubov.questionnaire.exception.init.AlreadyInitializedException;
import ru.obrubov.questionnaire.exception.init.InitializationException;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.OkResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.service.InitService;

@RestController
@RequestMapping("/init")
public class InitController {

    private static Logger logger = LoggerFactory.getLogger(InitController.class);

    private InitService initService;

    @Autowired
    public InitController(InitService initService) {
        this.initService = initService;
    }

    @PostMapping
    public Response initApp() {
        try {
            initService.init();
        } catch (AlreadyInitializedException e) {
            return ErrorResponse.create(403);
        } catch (InitializationException e) {
            logger.warn("Инициализация провалилась", e);
            return ErrorResponse.create(500);
        }
        return OkResponse.create();
    }
}
