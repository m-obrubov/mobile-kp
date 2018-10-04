package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.AuthInfoRepository;
import ru.obrubov.questionnaire.domain.AuthInfo;

@Service
public class AuthInfoDataAccess {

    private final AuthInfoRepository authInfoRepository;

    @Autowired
    public AuthInfoDataAccess(AuthInfoRepository authInfoRepository) {
        this.authInfoRepository = authInfoRepository;
    }

    public AuthInfo getByToken(String token) {
        return authInfoRepository.getByToken(token);
    }

    public AuthInfo create(AuthInfo authInfo) {
        return authInfoRepository.save(authInfo);
    }
}
