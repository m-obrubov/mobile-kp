package ru.obrubov.questionnaire.exception.jwt;

import ru.obrubov.questionnaire.exception.QuestionnaireRuntimeException;

public class ValidateTokenException extends QuestionnaireRuntimeException {

    public ValidateTokenException(String message) {
        super(message);
    }

}
