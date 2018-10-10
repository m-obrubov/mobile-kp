package ru.obrubov.questionnaire.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "test_result")
public class TestResult {
    @JsonIgnore
    private Long id;
    private LocalDateTime passedAt;
    private Test test;
    private User user;
    private Result resultCan;
    private Result resultWant;
    private Set<QuestionResult> questionResults;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @JsonProperty("passed_at")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Basic
    @Column(name = "passed_at")
    public LocalDateTime getPassedAt() {
        return passedAt;
    }

    @JsonIgnore
    public void setPassedAt(LocalDateTime passedAt) {
        this.passedAt = passedAt;
    }

    @JsonProperty("test")
    @ManyToOne
    @JoinColumn(name = "test_id", referencedColumnName = "id")
    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }

    @JsonProperty("user")
    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @JsonProperty("result_can")
    @ManyToOne
    @JoinColumn(name = "result_can_id", referencedColumnName = "id")
    public Result getResultCan() {
        return resultCan;
    }

    public void setResultCan(Result resultCan) {
        this.resultCan = resultCan;
    }

    @JsonProperty("result_want")
    @ManyToOne
    @JoinColumn(name = "result_want_id", referencedColumnName = "id")
    public Result getResultWant() {
        return resultWant;
    }

    public void setResultWant(Result resultWant) {
        this.resultWant = resultWant;
    }

    @JsonProperty("question_results")
    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable
            (
                    name = "test_result_question_result_join",
                    joinColumns = @JoinColumn(name = "test_result_id", referencedColumnName = "id"),
                    inverseJoinColumns = @JoinColumn(name = "question_result_id", referencedColumnName = "id", unique = true)
            )
    public Set<QuestionResult> getQuestionResults() {
        return questionResults;
    }

    public void setQuestionResults(Set<QuestionResult> questionResults) {
        this.questionResults = questionResults;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TestResult that = (TestResult) o;
        return Objects.equals(getId(), that.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
