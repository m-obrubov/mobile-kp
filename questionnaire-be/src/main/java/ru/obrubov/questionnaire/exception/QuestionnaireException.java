package ru.obrubov.questionnaire.exception;

public class QuestionnaireException extends Exception {
    public QuestionnaireException() {
        super();
    }

    public QuestionnaireException(String message) {
        super(message);
    }

    public QuestionnaireException(String message, Throwable cause) {
        super(message, cause);
    }

    public QuestionnaireException(Throwable cause) {
        super(cause);
    }
}
