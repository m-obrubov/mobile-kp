package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.AnswerRepository;
import ru.obrubov.questionnaire.domain.Answer;

@Service
public class AnswerDataAccess {

    private final AnswerRepository answerRepository;

    @Autowired
    public AnswerDataAccess(AnswerRepository answerRepository) {
        this.answerRepository = answerRepository;
    }

    public Answer getById(Long id) {
        return answerRepository.findById(id).orElse(null);
    }
}
