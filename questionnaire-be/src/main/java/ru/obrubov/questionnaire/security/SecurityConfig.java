package ru.obrubov.questionnaire.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import ru.obrubov.questionnaire.domain.Role;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserSecurityFilter userSecurityFilter;

    @Autowired
    public SecurityConfig(UserSecurityFilter userSecurityFilter) {
        this.userSecurityFilter = userSecurityFilter;
    }

    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                    // ACCOUNT
                    .antMatchers("/account/register", "/account/token").permitAll()
                    // USER
                    .antMatchers("/user").hasAuthority(Role.STUDENT.toString())
                    // TEST
                    .mvcMatchers(HttpMethod.POST, "/test").hasAuthority(Role.TEACHER.toString())
                    .mvcMatchers(HttpMethod.DELETE, "/test").hasAuthority(Role.TEACHER.toString())
                    .mvcMatchers(HttpMethod.GET, "/test").hasAnyAuthority(Role.STUDENT.toString(), Role.TEACHER.toString())
                    // RESULT
                    .anyRequest().authenticated()
                .and()
                    .addFilterBefore(userSecurityFilter, UsernamePasswordAuthenticationFilter.class)
                .csrf()
                    .disable();
        http
                .sessionManagement()
                    .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
    }

    @Bean
    public PasswordEncoder getPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
