package ru.obrubov.questionnaire.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "question")
public class Question {
    private Long id;
    private String value;
    private ProfessionalClass group;
    private TestPart part;
    private int numberInOrder;

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

    @JsonProperty("group")
    @Basic
    @Column(name = "question_group")
    public ProfessionalClass getGroup() {
        return group;
    }

    public void setGroup(ProfessionalClass group) {
        this.group = group;
    }

    @JsonProperty("part")
    @Basic
    @Column(name = "part")
    public TestPart getPart() {
        return part;
    }

    public void setPart(TestPart part) {
        this.part = part;
    }

    @JsonProperty("number_in_order")
    @Basic
    @Column(name = "number_in_order")
    public int getNumberInOrder() {
        return numberInOrder;
    }

    public void setNumberInOrder(int numberInOrder) {
        this.numberInOrder = numberInOrder;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Question question = (Question) o;
        return getNumberInOrder() == question.getNumberInOrder() &&
                Objects.equals(getId(), question.getId()) &&
                Objects.equals(getValue(), question.getValue()) &&
                getGroup() == question.getGroup() &&
                getPart() == question.getPart();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getValue(), getGroup(), getPart(), getNumberInOrder());
    }
}
