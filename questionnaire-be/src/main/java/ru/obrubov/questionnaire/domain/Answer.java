package ru.obrubov.questionnaire.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "answer")
public class Answer {
    private Long id;
    private String value;
    private int weight;

    @JsonProperty("id")
    @Id
    @Column(name = "id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @JsonProperty("value")
    @Basic
    @Column(name = "value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    //@JsonProperty("weight")
    @JsonIgnore
    @Basic
    @Column(name = "weight")
    public int getWeight() {
        return weight;
    }

    @JsonProperty("weight")
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
                Objects.equals(getValue(), answer.getValue());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getValue(), getWeight());
    }
}
