package ru.obrubov.questionnaire.data.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.repository.ResultRepository;
import ru.obrubov.questionnaire.domain.ProfessionalClass;
import ru.obrubov.questionnaire.domain.Result;

@Service
public class ResultDataAccess {

    private final ResultRepository resultRepository;

    @Autowired
    public ResultDataAccess(ResultRepository resultRepository) {
        this.resultRepository = resultRepository;
    }

    public Result getByWorkCharacterAndWorkSubject(ProfessionalClass workCharacter, ProfessionalClass workSubject) {
        return resultRepository.getByWorkCharacterAndWorkSubject(workCharacter, workSubject);
    }
}
