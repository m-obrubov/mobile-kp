package ru.obrubov.questionnaire.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.User;

@Service
public class AccessResolver {

    private final UserDataAccess userDataAccess;

    @Autowired
    public AccessResolver(UserDataAccess userDataAccess) {
        this.userDataAccess = userDataAccess;
    }

    public boolean getAccessByPassword(String ourPassword, String outerPassword) {
        //TODO сравнивать зашифрованный пароль
        return ourPassword.equals(outerPassword);
    }

    public User getCurrentUser() {
        String currentUserEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        return userDataAccess.getByEmail(currentUserEmail);
    }
}
