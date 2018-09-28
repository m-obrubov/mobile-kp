package ru.obrubov.questionnaire.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.AuthInfoDataAccess;
import ru.obrubov.questionnaire.domain.AuthInfo;
import javax.servlet.http.HttpServletRequest;

@Service
public class UserTokenProvider {

    private final AuthInfoDataAccess authInfoDataAccess;
    private final UserDetailsServiceImpl userDetailsService;

    @Autowired
    public UserTokenProvider(AuthInfoDataAccess authInfoDataAccess,
                             UserDetailsServiceImpl userDetailsService) {
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

}
