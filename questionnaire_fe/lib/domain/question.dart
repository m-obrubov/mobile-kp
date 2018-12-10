import 'package:questionnaire_fe/domain/answer.dart';

class Question {
  final int id;
  final String value;
  final int numberInOrder;

  Question(this.id, this.value, this.numberInOrder);

  factory Question.fromJson(Map<String, dynamic> json) {
    return new Question(
      json['id'],
      json['value'],
      json['number_in_order'],
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

  QuestionWithAnswers(int id, String value, int numberInOrder, this.answer) : super(id, value, numberInOrder);

  factory QuestionWithAnswers.fromJson(Map<String, dynamic> json) {
    return new QuestionWithAnswers(
      json['id'],
      json['value'],
      json['number_in_order'],
      Answer.listFromJson(json['answer'])
    );
  }
  static List<QuestionWithAnswers> listFromJson(List<dynamic> json) {
    List<QuestionWithAnswers> questionsWithAnswers = new List();
    for(dynamic d in json) {
      questionsWithAnswers.add(QuestionWithAnswers.fromJson(d));
    }
    return questionsWithAnswers;
  }
}