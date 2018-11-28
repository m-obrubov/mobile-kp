package ru.obrubov.questionnaire.response.account;

import ru.obrubov.questionnaire.domain.Role;

public class Token {
    private String token;
    private long lifetime; //время жизни токена
    private Role role;

    public Token(String token, long lifetime,Role role) {
        this.token = token;
        this.lifetime = lifetime;
        this.role = role;
    }

    public String getToken() {
        return token;
    }
}
