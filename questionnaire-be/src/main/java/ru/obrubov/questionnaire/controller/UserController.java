package ru.obrubov.questionnaire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.user.UserDataResponse;
import ru.obrubov.questionnaire.security.AccessResolver;
import ru.obrubov.questionnaire.service.UserService;

import javax.validation.Valid;

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
    public ResponseEntity<Response> getOwnData() {
        User currentUser = accessResolver.getCurrentUser();
        return ResponseEntity.ok(UserDataResponse.create(currentUser));
    }

    @PutMapping
    public ResponseEntity<Response> updateOwnData(@RequestBody User user) {
        Long currentUserId = accessResolver.getCurrentUser().getId();
        user.setId(currentUserId);
        User updatedUser = userService.update(user);
        if(updatedUser == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ErrorResponse.create("Ошибка на сервере. Обратитесь в службу поддержки."));
        }
        return ResponseEntity.ok(UserDataResponse.create(updatedUser));
    }
}
