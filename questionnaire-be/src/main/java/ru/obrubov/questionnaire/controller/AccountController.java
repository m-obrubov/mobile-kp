package ru.obrubov.questionnaire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.security.UserTokenProvider;
import ru.obrubov.questionnaire.service.UserService;

@RestController
@RequestMapping("/account")
public class AccountController {

    private final UserService userService;
    private final UserTokenProvider tokenProvider;

    @Autowired
    public AccountController(UserService userService,
                             UserTokenProvider tokenProvider) {
        this.userService = userService;
        this.tokenProvider = tokenProvider;
    }

    @PostMapping("/register")
    public String register(@RequestBody User user) {
        return userService.create(user).toString();
    }

    @GetMapping("/token")
    public String getTokenByLoginAndPassword(@RequestParam("login") String login,
                                             @RequestParam("password") String password) {
        String token = tokenProvider.generateToken(login, password);
        if(token == null) {
            return "";
        }
        return token;
    }
}
