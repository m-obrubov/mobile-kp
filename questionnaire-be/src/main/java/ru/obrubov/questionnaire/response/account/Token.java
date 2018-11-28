package ru.obrubov.questionnaire.response.account;

import ru.obrubov.questionnaire.domain.Role;

import javax.persistence.JoinColumn;

public class Token {
    private String token;
    private long lifetime; //время жизни токена
    private Role role;

    public Token(String token, long lifetime,Role role) {
        this.token = token;
        this.lifetime = lifetime;
        this.role = role;
    }

    @JoinColumn(name = "token")
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @JoinColumn(name = "lifetime")
    public long getLifetime() {
        return lifetime;
    }

    public void setLifetime(long lifetime) {
        this.lifetime = lifetime;
    }

    @JoinColumn(name = "role")
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
