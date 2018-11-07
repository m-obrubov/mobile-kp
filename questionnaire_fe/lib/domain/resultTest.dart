import 'package:questionnaire_fe/domain/profession.dart';
import 'package:questionnaire_fe/domain/question.dart';

class ResultTest {
  final String id;
  final String description;
  final List<Profession> professions;
  final List<QuestionWithAnswers> QuestionWithAnswersUser;

  ResultTest(this.id, this.description, this.professions, this.QuestionWithAnswersUser);
}