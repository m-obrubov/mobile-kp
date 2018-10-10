package ru.obrubov.questionnaire.data.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.obrubov.questionnaire.domain.ProfessionalClass;
import ru.obrubov.questionnaire.domain.Result;

@Repository
public interface ResultRepository extends JpaRepository<Result, Long> {
    Result getByWorkCharacterAndWorkSubject(ProfessionalClass workCharacter, ProfessionalClass workSubject);
}
