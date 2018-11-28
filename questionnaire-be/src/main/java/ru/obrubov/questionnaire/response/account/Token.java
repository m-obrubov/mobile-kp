package ru.obrubov.questionnaire.response.account;

import ru.obrubov.questionnaire.domain.Role;

import java.time.LocalDate;

public class Token {
    private String token;
    private LocalDate lifetime; //время жизни токена
    private Role role;

    public Token(String token, LocalDate lifetime,Role role) {
        this.token = token;
        this.lifetime = lifetime;
        this.role = role;
    }
}
