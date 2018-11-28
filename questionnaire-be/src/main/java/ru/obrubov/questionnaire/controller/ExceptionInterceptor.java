package ru.obrubov.questionnaire.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import ru.obrubov.questionnaire.response.ErrorResponse;

@RestControllerAdvice
public class ExceptionInterceptor {
    @ExceptionHandler(value = {Exception.class, RuntimeException.class})
    public ResponseEntity<ErrorResponse> onAny() {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ErrorResponse.create("Ошибка на сервере. Обратитесь в службу поддержки."));
    }
}
