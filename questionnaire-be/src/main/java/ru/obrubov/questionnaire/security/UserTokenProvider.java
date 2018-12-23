package ru.obrubov.questionnaire.security;

import io.jsonwebtoken.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.config.QuestionnaireConfig;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.User;
import ru.obrubov.questionnaire.response.account.Token;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;


@Service
public class UserTokenProvider {

    private final QuestionnaireConfig questionnaireConfig;
    private final UserDataAccess userDataAccess;
    private JwtParser jwtParser;

    @PostConstruct
    protected void init() {
        questionnaireConfig.setTokenSecretKey(Base64.getEncoder().encodeToString(questionnaireConfig.getTokenSecretKey().getBytes()));
    }

    @Autowired
    public UserTokenProvider(QuestionnaireConfig questionnaireConfig,
                             UserDataAccess userDataAccess) {
        this.questionnaireConfig = questionnaireConfig;
        this.userDataAccess = userDataAccess;
        this.jwtParser = Jwts.parser().setSigningKey(questionnaireConfig.getTokenSecretKey().getBytes());
    }

    private UserDetails getUserDetails(Jws<Claims> token) {
        Claims claims = token.getBody();
        String username = claims.getIssuer();
        List<SimpleGrantedAuthority> authorities = Collections.singletonList(new SimpleGrantedAuthority(claims.getSubject()));
        return org.springframework.security.core.userdetails.User.builder()
                .username(username)
                .password("")
                .authorities(authorities)
                .build();
    }

    Authentication getAuthentication(Jws<Claims> token) {
        UserDetails userDetails = getUserDetails(token);
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    Jws<Claims> resolveToken(HttpServletRequest req) {
        String header = req.getHeader(HttpHeaders.AUTHORIZATION);
        if(header != null) {
            return parseToken(header);
        }
        return null;
    }

    Jws<Claims> parseToken(String token) {
        try {
            return jwtParser.parseClaimsJws(token);
        } catch (JwtException | IllegalArgumentException e) {
            return null;
        }
    }

    public Token generate(String login) {
        User user = userDataAccess.getByEmail(login);
        String token = Jwts.builder()
                .setSubject(user.getEmail())
                .setIssuedAt(new Date())
                .setIssuer(user.getEmail())
                .setSubject(user.getRole().toString())
                .signWith(SignatureAlgorithm.HS256, questionnaireConfig.getTokenSecretKey()) //в кодировочке
                .compact();
        return new Token(token, user.getRole());
    }
}
