package ru.obrubov.questionnaire.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.config.QuestionnaireConfig;
import ru.obrubov.questionnaire.data.access.AuthInfoDataAccess;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.AuthInfo;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.exception.account.PermissionDeniedException;
import ru.obrubov.questionnaire.security.AccessResolver;
import ru.obrubov.questionnaire.security.UserTokenProvider;

import java.time.LocalDateTime;

@Service
public class TokenService {

    private final UserTokenProvider tokenProvider;
    private final UserDataAccess userDataAccess;
    private final AuthInfoDataAccess authInfoDataAccess;
    private final AccessResolver accessResolver;
    private final QuestionnaireConfig config;

    @Autowired
    public TokenService(UserTokenProvider tokenProvider,
                        UserDataAccess userDataAccess,
                        AuthInfoDataAccess authInfoDataAccess,
                        AccessResolver accessResolver,
                        QuestionnaireConfig config) {
        this.tokenProvider = tokenProvider;
        this.userDataAccess = userDataAccess;
        this.authInfoDataAccess = authInfoDataAccess;
        this.accessResolver = accessResolver;
        this.config = config;
    }

    public String generateToken(String login, String password) throws PermissionDeniedException {
        User user = userDataAccess.getByEmail(login);
        if(!accessResolver.getAccessByPassword(user.getPassword(), password)) {
            throw new PermissionDeniedException("Доступ запрещен. Пароли не совпадают");
        }
        String token = tokenProvider.generate(login, password);
        AuthInfo authInfo = new AuthInfo();
        authInfo.setUser(user);
        authInfo.setToken(token);
        authInfo.setExpiredAt(LocalDateTime.now().plusDays(config.getTokenExpireDays()));
        AuthInfo createdAuthInfo = authInfoDataAccess.create(authInfo);
        return createdAuthInfo.getToken();
    }
}
