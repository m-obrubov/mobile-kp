import 'package:questionnaire_fe/domain/constants.dart';
import 'package:questionnaire_fe/domain/profession.dart';
import 'package:questionnaire_fe/domain/question.dart';

class ResultTest {
  final int id;
  final Result resultCan;
  final Result resultWant;
  final List<QuestionWithAnswers> questionWithAnswersUser;
  final DateTime date;

  ResultTest(this.id, this.questionWithAnswersUser, this.date, this.resultCan, this.resultWant);

  factory ResultTest.fromJson(Map<String, dynamic> json) {
    String dataTime = json['passed_at']+"Z";
    return new ResultTest(
      json['id'],
      QuestionWithAnswers.listFromJson(json['question_results']),
      DateTime.parse(dataTime),
      Result.fromJson(json['result_can']),
      Result.fromJson(json['result_want']),
    );
  }

  static List<ResultTest> listFromJson(Map<String, dynamic> json) {
    List<ResultTest> results = new List();
    for(dynamic d in json['results']) {
      results.add(ResultTest.fromJson(d));
    }
    return results;
  }
}

class Result{
  final String description;
  final List<Profession> professions;
  final Work subject;//Предмет труда
  final Work character;//Характер труда

  Result(this.description, this.professions, this.subject, this.character); //Характер труда

  factory Result.fromJson(Map<String, dynamic> json) {
    return new Result(
      json['description'],
      Profession.listFromJson(json['professions']),
      Work.fromTitle(json['work_subject']),
      Work.fromTitle(json['work_character'])
    );
  }
}