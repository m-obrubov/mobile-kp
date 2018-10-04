package ru.obrubov.questionnaire.response;

import ru.obrubov.questionnaire.domain.User;

public class UserDataResponse extends User implements Response {
    private UserDataResponse(User user) {
        super();
        this.setId(user.getId());
        this.setFirstName(user.getFirstName());
        this.setLastName(user.getLastName());
        this.setAge(user.getAge());
        this.setCity(user.getCity());
        this.setGender(user.getGender());
        this.setEmail(user.getEmail());
        this.setCreatedAt(user.getCreatedAt());

    }

    public static UserDataResponse create(User user) {
        return new UserDataResponse(user);
    }
}
