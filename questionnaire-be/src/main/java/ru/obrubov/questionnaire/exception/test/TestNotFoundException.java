package ru.obrubov.questionnaire.exception.test;

import ru.obrubov.questionnaire.exception.QuestionnaireException;

public class TestNotFoundException extends QuestionnaireException {
    public TestNotFoundException() {
        super();
    }

    public TestNotFoundException(String message) {
        super(message);
    }

    public TestNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    public TestNotFoundException(Throwable cause) {
        super(cause);
    }
}
