package ru.obrubov.questionnaire.data.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.obrubov.questionnaire.domain.QuestionResult;

@Repository
public interface QuestionResultRepository extends JpaRepository<QuestionResult, Long> {
}
