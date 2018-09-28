package ru.obrubov.questionnaire.domain;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "auth_info")
public class AuthInfo {
    private Long id;
    private User user;
    private String token;
    private LocalDateTime expiredAt;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @ManyToOne
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Basic
    @Column(name = "token")
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Basic
    @Column(name = "expired_at")
    public LocalDateTime getExpiredAt() {
        return expiredAt != null ? expiredAt.withNano(0) : null;
    }

    public void setExpiredAt(LocalDateTime expiredAt) {
        this.expiredAt = expiredAt;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AuthInfo authInfo = (AuthInfo) o;
        return Objects.equals(getId(), authInfo.getId()) &&
                Objects.equals(getToken(), authInfo.getToken()) &&
                Objects.equals(getExpiredAt(), authInfo.getExpiredAt());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getToken(), getExpiredAt());
    }
}
