package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.QuestionResultRepository;
import ru.obrubov.questionnaire.domain.QuestionResult;

@Service
public class QuestionResultDataAccess {

    private final QuestionResultRepository questionResultRepository;

    @Autowired
    public QuestionResultDataAccess(QuestionResultRepository questionResultRepository) {
        this.questionResultRepository = questionResultRepository;
    }

    public QuestionResult create(QuestionResult questionResult) {
        return questionResultRepository.save(questionResult);
    }
}
