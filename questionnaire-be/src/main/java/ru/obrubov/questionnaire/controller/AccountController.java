package ru.obrubov.questionnaire.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.Role;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.exception.account.PermissionDeniedException;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.OkResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.account.TokenResponse;
import ru.obrubov.questionnaire.service.TokenService;
import ru.obrubov.questionnaire.service.UserService;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/account")
public class AccountController {

    private final Logger logger = LoggerFactory.getLogger(AccountController.class);

    private final UserService userService;
    private final TokenService tokenService;

    @Autowired
    public AccountController(UserService userService,
                             TokenService tokenService) {
        this.userService = userService;
        this.tokenService = tokenService;
    }

    @PostMapping("/register")
    public Response register(@RequestBody User user) {
        user.setCreatedAt(LocalDateTime.now());
        user.setRole(Role.STUDENT);
        //TODO шифровать пароль
        User createdUser = userService.create(user);
        if(createdUser == null) {
            return ErrorResponse.create(500);
        }
        return OkResponse.create();
    }

    @GetMapping("/token")
    public Response getTokenByLoginAndPassword(@RequestParam("login") String login,
                                               @RequestParam("password") String password) {
        String token;
        try {
            token = tokenService.generateToken(login, password);
        } catch (PermissionDeniedException e) {
            logger.info("Пользователь с логином {} ввел неправильный пароль", login);
            return ErrorResponse.create(403);
        }
        return TokenResponse.create(token);
    }
}
