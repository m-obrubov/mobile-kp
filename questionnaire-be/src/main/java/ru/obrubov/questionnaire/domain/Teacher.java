package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "teacher")
public class Teacher extends User {
    private Long id;
    private TestTheme testTheme;

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
    @Column(name = "test_theme")
    public TestTheme getTestTheme() {
        return testTheme;
    }

    public void setTestTheme(TestTheme testTheme) {
        this.testTheme = testTheme;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Teacher teacher = (Teacher) o;
        return Objects.equals(getId(), teacher.getId()) &&
                getTestTheme() == teacher.getTestTheme();
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), getId(), getTestTheme());
    }
}
