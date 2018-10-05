package ru.obrubov.questionnaire.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "test")
public class Test {
    private Long id;
    private String name;
    private String about;
    private String rules;
    private Set<Question> questions;
    private Set<Answer> answers;
    private Set<Result> results;

    private Set<TestResult> testResults;

    @JsonProperty("id")
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id")
    public Long getId() {
        return id;
    }

    @JsonIgnore
    public void setId(Long id) {
        this.id = id;
    }

    @JsonProperty("name")
    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonProperty("about")
    @Basic
    @Column(name = "about")
    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    @JsonProperty("rules")
    @Basic
    @Column(name = "rules")
    public String getRules() {
        return rules;
    }

    public void setRules(String rules) {
        this.rules = rules;
    }

    @JsonProperty("questions")
    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable
            (
                    name = "test_question_join",
                    joinColumns = @JoinColumn(name = "test_id", referencedColumnName = "id"),
                    inverseJoinColumns = @JoinColumn(name = "question_id", referencedColumnName = "id", unique = true)
            )
    public Set<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(Set<Question> questions) {
        this.questions = questions;
    }

    @JsonProperty("answers")
    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable
            (
                    name = "test_answer_join",
                    joinColumns = @JoinColumn(name = "test_id", referencedColumnName = "id"),
                    inverseJoinColumns = @JoinColumn(name = "answer_id", referencedColumnName = "id", unique = true)
            )
    public Set<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(Set<Answer> answers) {
        this.answers = answers;
    }

    @JsonProperty("results")
    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable
            (
                    name = "test_result_join",
                    joinColumns = @JoinColumn(name = "test_id", referencedColumnName = "id"),
                    inverseJoinColumns = @JoinColumn(name = "result_id", referencedColumnName = "id", unique = true)
            )
    public Set<Result> getResults() {
        return results;
    }

    public void setResults(Set<Result> results) {
        this.results = results;
    }

    @JsonIgnore
    @OneToMany(mappedBy = "test", cascade = CascadeType.REMOVE)
    public Set<TestResult> getTestResults() {
        return testResults;
    }

    public void setTestResults(Set<TestResult> testResults) {
        this.testResults = testResults;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Test test = (Test) o;
        return Objects.equals(getId(), test.getId()) &&
                Objects.equals(getName(), test.getName()) &&
                Objects.equals(getAbout(), test.getAbout()) &&
                Objects.equals(getRules(), test.getRules());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getName(), getAbout(), getRules());
    }
}
