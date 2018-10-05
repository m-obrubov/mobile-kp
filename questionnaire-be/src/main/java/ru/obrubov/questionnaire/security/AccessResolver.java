package ru.obrubov.questionnaire.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.User;

@Service
public class AccessResolver {

    private final UserDataAccess userDataAccess;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AccessResolver(UserDataAccess userDataAccess,
                          PasswordEncoder passwordEncoder) {
        this.userDataAccess = userDataAccess;
        this.passwordEncoder = passwordEncoder;
    }

    public String encryptPassword(String password) {
        return passwordEncoder.encode(password);
    }

    public boolean getAccessByPassword(String storedPassword, String outerPassword) {
        return passwordEncoder.matches(outerPassword, storedPassword);
    }

    public User getCurrentUser() {
        String currentUserEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        return userDataAccess.getByEmail(currentUserEmail);
    }
}
