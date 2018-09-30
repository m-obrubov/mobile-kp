package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "answer")
public class Answer {
    private Long id;
    private String value;
    private String description;
    private int weight;

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
    @Column(name = "weight")
    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Answer answer = (Answer) o;
        return getWeight() == answer.getWeight() &&
                Objects.equals(getId(), answer.getId()) &&
                Objects.equals(getValue(), answer.getValue()) &&
                Objects.equals(getDescription(), answer.getDescription());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getValue(), getDescription(), getWeight());
    }
}