package ru.obrubov.questionnaire.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.domain.Role;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.exception.account.PermissionDeniedException;
import ru.obrubov.questionnaire.exception.account.UsernameAlreadyExistsException;
import ru.obrubov.questionnaire.response.ErrorResponse;
import ru.obrubov.questionnaire.response.OkResponse;
import ru.obrubov.questionnaire.response.Response;
import ru.obrubov.questionnaire.response.account.TokenResponse;
import ru.obrubov.questionnaire.security.AccessResolver;
import ru.obrubov.questionnaire.service.TokenService;
import ru.obrubov.questionnaire.service.UserService;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/account")
public class AccountController {

    private final Logger logger = LoggerFactory.getLogger(AccountController.class);

    private final UserService userService;
    private final TokenService tokenService;
    private final AccessResolver accessResolver;

    @Autowired
    public AccountController(UserService userService,
                             TokenService tokenService,
                             AccessResolver accessResolver) {
        this.userService = userService;
        this.tokenService = tokenService;
        this.accessResolver = accessResolver;
    }

    @PostMapping("/register")
    public Response register(@RequestBody User user) {
        user.setCreatedAt(LocalDateTime.now());
        user.setRole(Role.STUDENT);
        user.setPassword(accessResolver.encryptPassword(user.getPassword()));
        User createdUser;
        try {
            createdUser = userService.create(user);
        } catch (UsernameAlreadyExistsException e) {
            logger.info("Пользователь с email = {} уже существует", user.getEmail());
            return ErrorResponse.create(1000);
        }
        if(createdUser == null) {
            return ErrorResponse.create(500);
        }
        return OkResponse.create();
    }

    @GetMapping("/token")
    public Response getTokenByLoginAndPassword(@RequestParam("login") String login,
                                               @RequestParam("password") String password) {
        if(!userService.isUserExists(login)) {
            return ErrorResponse.create(1001);
        }
        String token;
        try {
            token = tokenService.generateToken(login, password);
        } catch (PermissionDeniedException e) {
            logger.info("Пользователь с логином {} ввел неправильный пароль", login);
            return ErrorResponse.create(1001);
        }
        return TokenResponse.create(token);
    }

    @GetMapping("/check")
    public ResponseEntity checkAuthenticated(@RequestParam("token") String token) {
        if(tokenService.checkToken(token)) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
}
