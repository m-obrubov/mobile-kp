package ru.obrubov.questionnaire.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

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

    @JsonProperty("id")
    @Id
    @Column(name = "id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @JsonProperty("description")
    @Basic
    @Column(name = "description", length = 1024)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @JsonProperty("professions")
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable
            (
                    name = "result_profession_join",
                    joinColumns = @JoinColumn(name = "result_id", referencedColumnName = "id"),
                    inverseJoinColumns = @JoinColumn(name = "profession_id", referencedColumnName = "id", unique = true)
            )
    public Set<Profession> getProfessions() {
        return professions;
    }

    public void setProfessions(Set<Profession> professions) {
        this.professions = professions;
    }

    @JsonProperty("work_subject")
    @Basic
    @Column(name = "work_subject")
    public ProfessionalClass getWorkSubject() {
        return workSubject;
    }

    public void setWorkSubject(ProfessionalClass workSubject) {
        this.workSubject = workSubject;
    }

    @JsonProperty("work_character")
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
                Objects.equals(getProfessions(), result.getProfessions()) &&
                getWorkSubject() == result.getWorkSubject() &&
                getWorkCharacter() == result.getWorkCharacter();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getDescription(), getProfessions(), getWorkSubject(), getWorkCharacter());
    }
}
