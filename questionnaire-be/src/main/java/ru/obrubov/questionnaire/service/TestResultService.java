package ru.obrubov.questionnaire.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.obrubov.questionnaire.data.access.*;
import ru.obrubov.questionnaire.domain.*;
import ru.obrubov.questionnaire.exception.test.TestNotFoundException;
import ru.obrubov.questionnaire.security.AccessResolver;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TestResultService {

    private final TestResultDataAccess testResultDataAccess;
    private final AnswerDataAccess answerDataAccess;
    private final QuestionDataAccess questionDataAccess;
    private final AccessResolver accessResolver;
    private final TestDataAccess testDataAccess;
    private final ResultDataAccess resultDataAccess;

    @Autowired
    public TestResultService(TestResultDataAccess testResultDataAccess,
                             AnswerDataAccess answerDataAccess,
                             QuestionDataAccess questionDataAccess,
                             AccessResolver accessResolver,
                             TestDataAccess testDataAccess,
                             ResultDataAccess resultDataAccess) {
        this.testResultDataAccess = testResultDataAccess;
        this.answerDataAccess = answerDataAccess;
        this.questionDataAccess = questionDataAccess;
        this.accessResolver = accessResolver;
        this.testDataAccess = testDataAccess;
        this.resultDataAccess = resultDataAccess;
    }

    private Result calculateResult(Map<ProfessionalClass,Integer> resultGroup){ //высчитывание результата по списку вопросов

        ProfessionalClass workCharacter;
        ProfessionalClass workSubject;

        if (resultGroup.get(ProfessionalClass.EXECUTOR) > resultGroup.get(ProfessionalClass.CREATOR)){ //сравнение 2 последних групп
            workCharacter = ProfessionalClass.EXECUTOR;
        } else {
            workCharacter = ProfessionalClass.CREATOR;
        }
        resultGroup.remove(ProfessionalClass.EXECUTOR);
        resultGroup.remove(ProfessionalClass.CREATOR);
        workSubject = resultGroup.entrySet().stream().max((c1, c2) -> c1.getValue() > c2.getValue() ? 1 : -1).get().getKey();
        return resultDataAccess.getByWorkCharacterAndWorkSubject(workCharacter,workSubject);
    }

    public TestResult add(TestResult testResult, User user) throws TestNotFoundException {
        testResult.setPassedAt(LocalDateTime.now());
        testResult.setUser(user);
        Test test = testDataAccess.getOne();
        if (test == null){
            throw new TestNotFoundException("Нет тестов в БД");
        } else if (!test.getId().equals(testResult.getTest().getId())){
            throw new TestNotFoundException("Тест в базе данных с id = " + test.getId());
        }
        testResult.setTest(test);

        Map<ProfessionalClass,Integer> resultGroupCan = new HashMap<>();
        Map<ProfessionalClass,Integer> resultGroupWant = new HashMap<>();

        for (ProfessionalClass professional: ProfessionalClass.values()) {
            resultGroupCan.put(professional,0);
            resultGroupWant.put(professional,0);
        }

        for (QuestionResult questionResult:testResult.getQuestionResults()) { //сортируем и считаем
            Question question = questionDataAccess.getById(questionResult.getQuestion().getId()); //получаем вопрос
            Answer answer = answerDataAccess.getById(questionResult.getAnswer().getId());
            questionResult.setQuestion(question);
            questionResult.setAnswer(answer);
            if (question.getPart().equals(TestPart.CAN)){
                resultGroupCan.put(question.getGroup(),answer.getWeight()+resultGroupCan.get(question.getGroup()));
            } else if (question.getPart().equals(TestPart.WANT)) {
                resultGroupWant.put(question.getGroup(),answer.getWeight()+resultGroupWant.get(question.getGroup()));
            }
        }

        testResult.setResultWant(calculateResult(resultGroupWant));
        testResult.setResultCan(calculateResult(resultGroupCan));

        return testResultDataAccess.create(testResult);
    }

    public List<TestResult> getOwnResults(Long userId){
        return testResultDataAccess.getByUserId(userId);
    }
}
