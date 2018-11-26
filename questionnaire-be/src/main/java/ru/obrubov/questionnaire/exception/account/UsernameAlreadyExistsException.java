package ru.obrubov.questionnaire.exception.account;

import ru.obrubov.questionnaire.exception.QuestionnaireException;

public class UsernameAlreadyExistsException extends QuestionnaireException {
    public UsernameAlreadyExistsException() {
        super();
    }

    public UsernameAlreadyExistsException(String message) {
        super(message);
    }

    public UsernameAlreadyExistsException(String message, Throwable cause) {
        super(message, cause);
    }

    public UsernameAlreadyExistsException(Throwable cause) {
        super(cause);
    }
}
