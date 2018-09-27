package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "result")
public class Result {
    private Long id;
    private String value;
    private String description;
    private int pointsFrom;
    private int pointsTo;

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
    @Column(name = "points_from")
    public int getPointsFrom() {
        return pointsFrom;
    }

    public void setPointsFrom(int pointsFrom) {
        this.pointsFrom = pointsFrom;
    }

    @Basic
    @Column(name = "points_to")
    public int getPointsTo() {
        return pointsTo;
    }

    public void setPointsTo(int pointsTo) {
        this.pointsTo = pointsTo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Result result = (Result) o;
        return getPointsFrom() == result.getPointsFrom() &&
                getPointsTo() == result.getPointsTo() &&
                Objects.equals(getId(), result.getId()) &&
                Objects.equals(getValue(), result.getValue()) &&
                Objects.equals(getDescription(), result.getDescription());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getValue(), getDescription(), getPointsFrom(), getPointsTo());
    }
}
