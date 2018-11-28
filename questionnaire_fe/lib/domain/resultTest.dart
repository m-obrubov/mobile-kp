import 'package:questionnaire_fe/domain/profession.dart';
import 'package:questionnaire_fe/domain/question.dart';

class ResultTest {
  final int id;
  final String description;
  final List<Profession> professions;
  final List<QuestionWithAnswers> QuestionWithAnswersUser;
  final String group;//Предмет труда
  final String part; //Характер труда
  final DateTime date;

  ResultTest(this.id, this.description, this.professions, this.QuestionWithAnswersUser, this.group, this.part, this.date);
}