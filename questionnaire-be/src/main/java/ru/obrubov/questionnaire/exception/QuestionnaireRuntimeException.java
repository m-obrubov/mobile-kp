package ru.obrubov.questionnaire.exception;

public class QuestionnaireRuntimeException extends RuntimeException {
    public QuestionnaireRuntimeException() {
        super();
    }

    public QuestionnaireRuntimeException(String message) {
        super(message);
    }

    public QuestionnaireRuntimeException(String message, Throwable cause) {
        super(message, cause);
    }

    public QuestionnaireRuntimeException(Throwable cause) {
        super(cause);
    }
}
