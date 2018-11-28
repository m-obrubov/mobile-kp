package ru.obrubov.questionnaire.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
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
                    .antMatchers("/account/*","/test").permitAll()
                    // USER
                    .antMatchers("/user").hasAuthority(Role.STUDENT.toString())
                    // RESULT
                    .antMatchers("/result").hasAuthority(Role.STUDENT.toString())
                    .antMatchers("/result/all").hasAuthority(Role.TEACHER.toString())
                    .anyRequest().authenticated()
                .and()
                    .addFilterBefore(userSecurityFilter, UsernamePasswordAuthenticationFilter.class)
                .csrf()
                    .disable()
                .sessionManagement()
                    .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                    .exceptionHandling()
                        .defaultAuthenticationEntryPointFor(
                                new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED), new AntPathRequestMatcher("/**")
                        );
    }

    @Bean
    public PasswordEncoder getPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
