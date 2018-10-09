package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.QuestionRepository;
import ru.obrubov.questionnaire.domain.Question;

@Service
public class QuestionDataAccess {

    private final QuestionRepository questionRepository;

    @Autowired
    public QuestionDataAccess(QuestionRepository questionRepository) {
        this.questionRepository = questionRepository;
    }

    public Question getById(Long id) {
        return questionRepository.findById(id).orElse(null);
    }
}
