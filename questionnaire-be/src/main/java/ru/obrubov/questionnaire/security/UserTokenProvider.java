package ru.obrubov.questionnaire.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.config.QuestionnaireConfig;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.Base64;
import java.util.Date;


@Service
public class UserTokenProvider {

    private final UserDetailsServiceImpl userDetailsService;
    private final QuestionnaireConfig questionnaireConfig;

    @PostConstruct
    protected void init() {
        questionnaireConfig.setTokenSecretKey(Base64.getEncoder().encodeToString(questionnaireConfig.getTokenSecretKey().getBytes()));
    }

    @Autowired
    public UserTokenProvider(UserDetailsServiceImpl userDetailsService,
                             QuestionnaireConfig questionnaireConfig) {
        this.userDetailsService = userDetailsService;
        this.questionnaireConfig = questionnaireConfig;
    }

    Authentication getAuthentication(String token) {
        UserDetails userDetails = userDetailsService.loadUserByUsername(getUserName(token));
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    private String getUserName(String token) {
        return Jwts.parser().setSigningKey(questionnaireConfig.getTokenSecretKey()).parseClaimsJws(token).getBody().getSubject();
    }

    String resolveToken(HttpServletRequest req) {
        return req.getHeader("Authorization");
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(questionnaireConfig.getTokenSecretKey()).parseClaimsJws(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    public String generate(String login) {
        Claims claims = Jwts.claims().setSubject(login);
        Date now = new Date();
        Date validity = new Date(now.getTime()+ questionnaireConfig.getTokenExpireMinutes()*60000);// действительность в милисикундах
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(validity)
                .signWith(SignatureAlgorithm.HS256, questionnaireConfig.getTokenSecretKey()) //в кодировочке
                .compact();
    }
}
