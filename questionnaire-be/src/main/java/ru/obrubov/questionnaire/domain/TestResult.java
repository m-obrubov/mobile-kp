package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "test_result")
public class TestResult {
    private Long id;
    private LocalDateTime passedAt;
    private Test test;
    private User user;
    private int totalPoints;
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

    @Basic
    @Column(name = "passed_at")
    public LocalDateTime getPassedAt() {
        return passedAt;
    }

    public void setPassedAt(LocalDateTime passedAt) {
        this.passedAt = passedAt;
    }

    @ManyToOne
    @JoinColumn(name = "test_id", referencedColumnName = "id")
    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Basic
    @Column(name = "total_points")
    public int getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(int totalPoints) {
        this.totalPoints = totalPoints;
    }

    @OneToMany
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
        return getTotalPoints() == that.getTotalPoints() &&
                Objects.equals(getId(), that.getId()) &&
                Objects.equals(getPassedAt(), that.getPassedAt());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getPassedAt(), getTotalPoints());
    }
}
