package ru.obrubov.questionnaire.controller;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import ru.obrubov.questionnaire.exception.jwt.ValidateTokenException;
import ru.obrubov.questionnaire.response.ErrorResponse;

@RestControllerAdvice
public class ExceptionInterceptor {
    @ExceptionHandler(value = {Exception.class, RuntimeException.class})
    public ErrorResponse onAny() {
        return ErrorResponse.create(500);
    }

    @ExceptionHandler(value = ValidateTokenException.class)
    public ErrorResponse onTokenNotValid() {
        return ErrorResponse.create(401);
    }
}
