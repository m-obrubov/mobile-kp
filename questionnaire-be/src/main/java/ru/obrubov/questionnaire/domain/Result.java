package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "result")
public class Result {
    private Long id;
    private String description;
    private Set<Profession> professions;
    private ProfessionalClass workSubject;
    private ProfessionalClass workCharacter;

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
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @OneToMany(mappedBy = "result")
    public Set<Profession> getProfessions() {
        return professions;
    }

    public void setProfessions(Set<Profession> professions) {
        this.professions = professions;
    }

    @Basic
    @Column(name = "work_subject")
    public ProfessionalClass getWorkSubject() {
        return workSubject;
    }

    public void setWorkSubject(ProfessionalClass workSubject) {
        this.workSubject = workSubject;
    }

    @Basic
    @Column(name = "work_character")
    public ProfessionalClass getWorkCharacter() {
        return workCharacter;
    }

    public void setWorkCharacter(ProfessionalClass workCharacter) {
        this.workCharacter = workCharacter;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Result result = (Result) o;
        return Objects.equals(getId(), result.getId()) &&
                Objects.equals(getDescription(), result.getDescription()) &&
                getWorkSubject() == result.getWorkSubject() &&
                getWorkCharacter() == result.getWorkCharacter();
    }

    @Override
    public int hashCode() {

        return Objects.hash(getId(), getDescription(), getWorkSubject(), getWorkCharacter());
    }
}
