package ru.obrubov.questionnaire.data.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.obrubov.questionnaire.domain.AuthInfo;

@Repository
public interface AuthInfoRepository extends JpaRepository<AuthInfo, Long> {
    AuthInfo getByToken(String token);
}
