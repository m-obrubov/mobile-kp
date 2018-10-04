package ru.obrubov.questionnaire.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.User;

import java.util.List;

@Service
public class UserService {

    private final UserDataAccess userDataAccess;

    @Autowired
    public UserService(UserDataAccess userDataAccess) {
        this.userDataAccess = userDataAccess;
    }

    public User create(User user) {
        return userDataAccess.create(user);
    }

    public User getById(Long id) {
        return userDataAccess.getById(id);
    }

    public List<User> getAll() {
        return userDataAccess.getAll();
    }

    public User update(User user) {
        User storedUser = getById(user.getId());
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
}
