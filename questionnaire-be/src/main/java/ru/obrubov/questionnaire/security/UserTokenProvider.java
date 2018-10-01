package ru.obrubov.questionnaire.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.AuthInfoDataAccess;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.AuthInfo;
import ru.obrubov.questionnaire.domain.User;

import javax.servlet.http.HttpServletRequest;

@Service
public class UserTokenProvider {

    private final UserDataAccess userDataAccess;
    private final AuthInfoDataAccess authInfoDataAccess;
    private final UserDetailsServiceImpl userDetailsService;

    @Autowired
    public UserTokenProvider(UserDataAccess userDataAccess,
                             AuthInfoDataAccess authInfoDataAccess,
                             UserDetailsServiceImpl userDetailsService) {
        this.userDataAccess = userDataAccess;
        this.authInfoDataAccess = authInfoDataAccess;
        this.userDetailsService = userDetailsService;
    }

    Authentication getAuthentication(String token) {
        AuthInfo authInfo = authInfoDataAccess.getByToken(token);
        UserDetails userDetails = userDetailsService.loadUserByUsername(authInfo.getUser().getEmail());
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    String resolveToken(HttpServletRequest req) {
        return req.getHeader("Authorization");
    }

    boolean validateToken(String token) {
        AuthInfo authInfo = authInfoDataAccess.getByToken(token);
        return authInfo != null;
    }

    public String generateToken(String login, String password) {
        UserDetails userDetails = userDetailsService.loadUserByUsername(login);
        if(!userDetails.getPassword().equals(password)) {
            return null;
        }
        return "OK";
    }
}
