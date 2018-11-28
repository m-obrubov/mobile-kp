package ru.obrubov.questionnaire.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.config.QuestionnaireConfig;
import ru.obrubov.questionnaire.data.access.AuthInfoDataAccess;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.AuthInfo;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.exception.account.PermissionDeniedException;
import ru.obrubov.questionnaire.response.account.Token;
import ru.obrubov.questionnaire.security.AccessResolver;
import ru.obrubov.questionnaire.security.UserTokenProvider;

@Service
public class TokenService {

    private final UserTokenProvider tokenProvider;
    private final UserDataAccess userDataAccess;
    private final AuthInfoDataAccess authInfoDataAccess;
    private final AccessResolver accessResolver;

    @Autowired
    public TokenService(UserTokenProvider tokenProvider,
                        UserDataAccess userDataAccess,
                        AuthInfoDataAccess authInfoDataAccess,
                        AccessResolver accessResolver) {
        this.tokenProvider = tokenProvider;
        this.userDataAccess = userDataAccess;
        this.authInfoDataAccess = authInfoDataAccess;
        this.accessResolver = accessResolver;
    }

    public Token generateToken(String login, String password) throws PermissionDeniedException {
        User user = userDataAccess.getByEmail(login);
        if(!accessResolver.getAccessByPassword(user.getPassword(), password)) {
            throw new PermissionDeniedException("Доступ запрещен. Пароли не совпадают");
        }
        Token token = tokenProvider.generate(login);//, password
        AuthInfo authInfo = new AuthInfo();
        authInfo.setUser(user);
        authInfo.setToken(token.getToken());
        if (authInfoDataAccess.create(authInfo) == null) {
            return token;
        }
        return null;
    }

}
