package ru.obrubov.questionnaire.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.obrubov.questionnaire.response.Response;

@RestController
@RequestMapping("/result")
public class ResultController {

    @PostMapping
    public Response addResult() {
        //TODO
        return null;
    }

    @GetMapping
    public Response getOwnResults() {
        //TODO
        return null;
    }

    @GetMapping("/all")
    public Response getAllResults() {
        return null;
    }
}
