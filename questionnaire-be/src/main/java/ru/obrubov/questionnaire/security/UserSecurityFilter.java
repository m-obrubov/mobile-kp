package ru.obrubov.questionnaire.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;
import ru.obrubov.questionnaire.exception.jwt.ValidateTokenException;
import ru.obrubov.questionnaire.response.ErrorResponse;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class UserSecurityFilter extends GenericFilterBean {

    private final UserTokenProvider tokenProvider;
    private final ObjectMapper objectMapper;

    @Autowired
    public UserSecurityFilter(UserTokenProvider tokenProvider, ObjectMapper objectMapper) {
        this.tokenProvider = tokenProvider;
        this.objectMapper = objectMapper;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        try {
            String token = tokenProvider.resolveToken((HttpServletRequest) servletRequest);
            if(token != null && tokenProvider.validateToken(token)) {
                Authentication authentication = tokenProvider.getAuthentication(token);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
            filterChain.doFilter(servletRequest, servletResponse);
        } catch (ValidateTokenException e) {
            HttpServletResponse response = (HttpServletResponse) servletResponse;
            response.getWriter().append(objectMapper.writeValueAsString(ErrorResponse.create(401)));
            response.setContentType(MediaType.APPLICATION_JSON_UTF8_VALUE);
        }
    }
}
