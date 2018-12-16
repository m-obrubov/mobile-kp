import 'package:questionnaire_fe/domain/answer.dart';

class Question {
  final int id;
  String value;
  int numberInOrder;

  Question(this.id, {this.value, this.numberInOrder});

  factory Question.fromJson(Map<String, dynamic> json) {
    return new Question(
      json['id'],
      value: json['value'],
      numberInOrder: json['number_in_order'],
    );
  }
  static List<Question> listFromJson(List<dynamic> json) {
    List<Question> questions = new List();
    for(dynamic d in json) {
      questions.add(Question.fromJson(d));
    }
    return questions;
  }
}

class QuestionWithAnswers extends Question {
  final List<Answer> answer;

  QuestionWithAnswers(int id, this.answer, {String value, int numberInOrder}) : super(id, value: value, numberInOrder: numberInOrder);

  factory QuestionWithAnswers.fromJson(Map<String, dynamic> json) {
    Answer answer =  Answer.fromJson(json['answer']);
    List<Answer> answers = new List();
    answers.add(answer);
    return new QuestionWithAnswers(
      json['question']["id"],
      answers,
      value: json['question']['value'],
      numberInOrder: json['question']['number_in_order'],
    );
  }

  static Map<String, dynamic> toJsonResult(List<QuestionWithAnswers> result,int idTest) {
    List<dynamic> resultQuestionAndAnswers = new List<dynamic>();
    for (QuestionWithAnswers q in result){
      resultQuestionAndAnswers.add(toJsonQuestionAndAnswers(q));
    }
    return {
      "test": {
        "id": idTest
      },
      "question_results": resultQuestionAndAnswers
    };
  }

  static Map<String, dynamic> toJsonQuestionAndAnswers(QuestionWithAnswers q){
    return {
      "question": {
        "id": q.id
      },
      "answer": {
        "id": q.answer[0].id
      }
    };
  }

  static List<QuestionWithAnswers> listFromJson(List<dynamic> json) {
    List<QuestionWithAnswers> questionsWithAnswers = new List();
    for(dynamic d in json) {
      questionsWithAnswers.add(QuestionWithAnswers.fromJson(d));
    }
    return questionsWithAnswers;
  }
}