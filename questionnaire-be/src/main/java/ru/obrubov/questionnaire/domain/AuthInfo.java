package ru.obrubov.questionnaire.domain;

import java.time.LocalDateTime;

public class AuthInfo {
    private Long id;
    private User user;
    private String token;
    private LocalDateTime expiredAt;
}
