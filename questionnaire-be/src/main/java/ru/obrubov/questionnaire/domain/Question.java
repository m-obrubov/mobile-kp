package ru.obrubov.questionnaire.domain;

import java.util.Set;

public class Question {
    private Long id;
    private String value;
    private String description;
    private int numberInOrder;
    private boolean isMultiChoice;
    private Set<Answer> answers;
}
