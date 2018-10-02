package ru.obrubov.questionnaire.exception.account;

import ru.obrubov.questionnaire.exception.QuestionnaireException;

public class PermissionDeniedException extends QuestionnaireException {
    public PermissionDeniedException() {
        super();
    }

    public PermissionDeniedException(String message) {
        super(message);
    }

    public PermissionDeniedException(String message, Throwable cause) {
        super(message, cause);
    }

    public PermissionDeniedException(Throwable cause) {
        super(cause);
    }
}
