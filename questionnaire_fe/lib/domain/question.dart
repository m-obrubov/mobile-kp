import 'package:questionnaire_fe/domain/answer.dart';

class QuestionWithAnswers {
  final String id;
  final String value;
  final int numberInOrder;
  final List<Answer> answer;

  QuestionWithAnswers(this.id, this.numberInOrder, this.value, this.answer);

}