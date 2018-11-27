package ru.obrubov.questionnaire.exception.init;

import ru.obrubov.questionnaire.exception.QuestionnaireException;

public class InitializationException extends QuestionnaireException {
    public InitializationException(String message) {
        super();
    }

    public InitializationException(String message, Throwable cause) {
        super(message, cause);
    }
}
