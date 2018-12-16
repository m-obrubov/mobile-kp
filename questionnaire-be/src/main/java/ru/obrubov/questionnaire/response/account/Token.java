package ru.obrubov.questionnaire.response.account;

import com.fasterxml.jackson.annotation.JsonProperty;
import ru.obrubov.questionnaire.domain.Role;

public class Token {
    private String token;
    private Role role;

    public Token(String token, Role role) {
        this.token = token;
        this.role = role;
    }

    @JsonProperty("token")
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @JsonProperty("role")
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
