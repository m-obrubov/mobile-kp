package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.UserRepository;
import ru.obrubov.questionnaire.domain.User;

@Service
public class UserDataAccess {

    private final UserRepository userRepository;

    @Autowired
    public UserDataAccess(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User create(User user) {
        return userRepository.save(user);
    }

    public User getById(Long id) {
        return userRepository.getOne(id);
    }

    public User getByEmail(String email) {
        return userRepository.getByEmail(email);
    }

    public User update(User user) {
        return userRepository.save(user);
    }
}
