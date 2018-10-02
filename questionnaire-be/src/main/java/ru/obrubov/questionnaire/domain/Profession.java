package ru.obrubov.questionnaire.domain;

import javax.persistence.*;

@Entity
@Table(name = "profession")
public class Profession {
    private Long id;
    private String value;
    private Result result;

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

    @ManyToOne
    @JoinColumn(name = "result_id", referencedColumnName = "id")
    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
    }


}
