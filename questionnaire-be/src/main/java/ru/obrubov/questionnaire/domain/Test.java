package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "test")
public class Test {
    private Long id;
    private String name;
    private String description;
    private TestTheme theme;
    private Set<Question> questions;
    private Set<Result> results;

    private Set<TestResult> testResults;

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
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
    @Column(name = "theme")
    public TestTheme getTheme() {
        return theme;
    }

    public void setTheme(TestTheme theme) {
        this.theme = theme;
    }

    @OneToMany
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

    @OneToMany
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

    @OneToMany(mappedBy = "test")
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
                Objects.equals(getDescription(), test.getDescription()) &&
                getTheme() == test.getTheme();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getName(), getDescription(), getTheme());
    }
}
