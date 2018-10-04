package ru.obrubov.questionnaire;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import ru.obrubov.questionnaire.config.QuestionnaireConfig;

@SpringBootApplication
@EnableJpaRepositories("ru.obrubov.questionnaire.data.repository")
@EnableConfigurationProperties(QuestionnaireConfig.class)
public class QuestionnaireApplication {
    public static void main(String[] args) {
        SpringApplication.run(QuestionnaireApplication.class, args);
    }
}
