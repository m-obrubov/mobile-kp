package ru.obrubov.questionnaire.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.exception.account.UsernameAlreadyExistsException;

@Service
public class UserService {

    private final UserDataAccess userDataAccess;

    @Autowired
    public UserService(UserDataAccess userDataAccess) {
        this.userDataAccess = userDataAccess;
    }

    public User create(User user) throws UsernameAlreadyExistsException {
        User storedUser = userDataAccess.getByEmail(user.getEmail());
        if(storedUser != null) {
            throw new UsernameAlreadyExistsException();
        }
        return userDataAccess.create(user);
    }

    public User update(User user) {
        User storedUser = userDataAccess.getById(user.getId());
        if(user.getFirstName() != null) {
            storedUser.setFirstName(user.getFirstName());
        }
        if(user.getLastName() != null) {
            storedUser.setLastName(user.getLastName());
        }
        if(user.getAge() != 0) {
            storedUser.setAge(user.getAge());
        }
        if(user.getCity() != null) {
            storedUser.setCity(user.getCity());
        }
        if(user.getGender() != null) {
            storedUser.setGender(user.getGender());
        }
        if(user.getEmail() != null) {
            storedUser.setEmail(user.getEmail());
        }
        return userDataAccess.update(storedUser);
    }

    public boolean isUserExists(String email) {
        User user = userDataAccess.getByEmail(email);
        return user != null;
    }
}
