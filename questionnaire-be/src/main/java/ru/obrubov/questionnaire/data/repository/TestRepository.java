package ru.obrubov.questionnaire.data.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.obrubov.questionnaire.domain.Test;

@Repository
public interface TestRepository extends JpaRepository<Test, Long>, TestRepositoryCustom {
}
