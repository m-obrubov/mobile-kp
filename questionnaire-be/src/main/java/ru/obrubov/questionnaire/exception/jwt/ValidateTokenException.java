package ru.obrubov.questionnaire.exception.jwt;

import ru.obrubov.questionnaire.exception.QuestionnaireException;

public class ValidateTokenException extends QuestionnaireException {

    public ValidateTokenException(String message) {
        super(message);
    }

}
