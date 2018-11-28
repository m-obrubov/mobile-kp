import 'package:questionnaire_fe/domain/answer.dart';
import 'package:questionnaire_fe/domain/question.dart';

class Test {
  int id;
  String name;
  String about;
  String rules;
  List<Question> questions;
  List<Answer> answers;

  Test(this.id, this.name, this.about, this.rules, this.questions,
      this.answers);

  factory Test.fromJson(Map<String, dynamic> json) {
    return new Test(
      json['id'],
      json['name'],
      json['about'],
      json['rules'],
      Question.listFromJson(json['questions']),
      Answer.listFromJson(json['answers'])
    );
  }
}