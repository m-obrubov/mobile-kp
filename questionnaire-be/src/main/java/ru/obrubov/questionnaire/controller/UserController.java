package ru.obrubov.questionnaire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.obrubov.questionnaire.service.UserService;
import ru.obrubov.questionnaire.domain.User;

@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    //TODO all
    @GetMapping("/all")
    public String getAll() {
        return userService.getAll().toString();
    }

    //TODO id
    @GetMapping("/id")
    public String getById(@RequestParam("id") Long id) {
        return userService.getById(id).toString();
    }

    //TODO data
    @GetMapping("/data")
    public String getOwnData() {
        Long id = 1L;
        return userService.getById(id).toString();
    }

    //TODO update
    @PutMapping("/update")
    public String updateOwnData(@RequestBody User user) {
        return userService.update(user).toString();
    }

}
