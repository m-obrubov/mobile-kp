package ru.obrubov.questionnaire.security;

import org.springframework.stereotype.Service;

@Service
public class AccessProvider {
    public boolean getAccessByPassword(String ourPassword, String outerPassword) {
        //TODO сравнивать зашифрованный пароль
        return ourPassword.equals(outerPassword);
    }
}
