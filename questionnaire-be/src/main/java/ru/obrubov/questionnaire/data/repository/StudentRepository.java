package ru.obrubov.questionnaire.data.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.obrubov.questionnaire.domain.Student;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
}
