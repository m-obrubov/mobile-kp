package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "question")
public class Question {
    private Long id;
    private String value;
    private String description;
    private int numberInOrder;
    private boolean isMultiChoice;
    private Set<Answer> answers;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Basic
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Basic
    @Column(name = "number_in_order")
    public int getNumberInOrder() {
        return numberInOrder;
    }

    public void setNumberInOrder(int numberInOrder) {
        this.numberInOrder = numberInOrder;
    }

    @Basic
    @Column(name = "is_multi_choice")
    public boolean isMultiChoice() {
        return isMultiChoice;
    }

    public void setMultiChoice(boolean multiChoice) {
        isMultiChoice = multiChoice;
    }

    @OneToMany
    @JoinTable
            (
                    name = "question_answer_join",
                    joinColumns = @JoinColumn(name = "question_id", referencedColumnName = "id"),
                    inverseJoinColumns = @JoinColumn(name = "answer_id", referencedColumnName = "id", unique = true)
            )
    public Set<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(Set<Answer> answers) {
        this.answers = answers;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Question question = (Question) o;
        return getNumberInOrder() == question.getNumberInOrder() &&
                isMultiChoice() == question.isMultiChoice() &&
                Objects.equals(getId(), question.getId()) &&
                Objects.equals(getValue(), question.getValue()) &&
                Objects.equals(getDescription(), question.getDescription());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getValue(), getDescription(), getNumberInOrder(), isMultiChoice());
    }
}
