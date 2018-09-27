package ru.obrubov.questionnaire.domain;

import java.time.LocalDateTime;
import java.util.Set;

public class TestResult {
    private Long id;
    private LocalDateTime passedAt;
    private Test test;
    private User user;
    private int totalPoints;
    private Set<QuestionResult> questionResults;
}
