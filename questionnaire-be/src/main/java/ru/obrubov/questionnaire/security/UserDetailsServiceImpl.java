package ru.obrubov.questionnaire.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.UserDataAccess;
import ru.obrubov.questionnaire.domain.User;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserDataAccess userDataAccess;

    @Autowired
    public UserDetailsServiceImpl(UserDataAccess userDataAccess) {
        this.userDataAccess = userDataAccess;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userDataAccess.getByEmail(username);
        if(user == null) {
            throw new UsernameNotFoundException("Не найден пользователь с email = " + username);
        }
        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .authorities(user.getRole().toString())
                .build();
    }
}
