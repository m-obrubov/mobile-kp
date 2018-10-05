package ru.obrubov.questionnaire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.user.UserDataResponse;
import ru.obrubov.questionnaire.security.AccessResolver;
import ru.obrubov.questionnaire.service.UserService;

@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final AccessResolver accessResolver;

    @Autowired
    public UserController(UserService userService, AccessResolver accessResolver) {
        this.userService = userService;
        this.accessResolver = accessResolver;
    }

    @GetMapping
    public Response getOwnData() {
        User currentUser = accessResolver.getCurrentUser();
        return UserDataResponse.create(currentUser);
    }

    @PutMapping
    public Response updateOwnData(@RequestBody User user) {
        Long currentUserId = accessResolver.getCurrentUser().getId();
        user.setId(currentUserId);
        User updatedUser = userService.update(user);
        if(updatedUser == null) {
            return ErrorResponse.create(500);
        }
        return UserDataResponse.create(updatedUser);
    }
}
