import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/answer.dart';
import 'package:questionnaire_fe/domain/question.dart';
import 'package:questionnaire_fe/domain/test.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/result.dart';

class QuestionPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _QuestionPageState();

}

class _QuestionPageState extends State<QuestionPage> {

  Test _test;
  int _countQuestion; //Общее кол-во вопросов
  QuestionWithAnswers _currentQuestion; //текущий вопрос
  var _answerUser; // ответ пользователя
  List<QuestionWithAnswers> _questionsWithAnswers; //Список ответов на вопросы пользователя

  _QuestionPageState();

  @override
  void initState() {
    // TODO: достать тест
    _test.questions.sort((o1,o2) => o1.numberInOrder.compareTo(o2.numberInOrder));
    _countQuestion = _test.questions.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listRadioListTile  = new List();
    Widget widgetRadioListTile;
    for (int i = 0; i < _currentQuestion.answer.length; i++) {
      Answer answer = _currentQuestion.answer[i];
      listRadioListTile.add (RadioListTile<String>(
        value: answer.id.toString(),
        groupValue: _answerUser,
        onChanged: _handleChoice,
        title:
          Text(
            answer.value,
            style: TextStyle(
                fontSize: 18.0
            ),
          ),
        )
      );
    }
    widgetRadioListTile = new Column(children: listRadioListTile);
    return Scaffold(
        appBar: AppBar(
          title: Text("Вопрос " + _currentQuestion.numberInOrder.toString() + " из " + _countQuestion.toString() + "."),
        ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 2.0),
              child: Column(
                children: <Widget>[
                  Text(
                      "\n" + _currentQuestion.value + "\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      )
                  ),
                  // TODO тут дожен появиться цикл
                  widgetRadioListTile,
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: WideRaisedButton(
                        text: "Ответить",
                        onPressed: _submit,
                        fontSize: 20.0,
                    )
                  )
                ],
              ),
            )
        )
    );
  }

  void _submit() {
    if (_answerUser != null) {
      List<Answer> ansver = new List(1);
      ansver.add(Answer(_answerUser)); //заворачиваем ответ пользователя
      _questionsWithAnswers.add(new QuestionWithAnswers(_currentQuestion.id,ansver);
      if (_currentQuestion.numberInOrder != _countQuestion) {
        //TODO вызвать переход на эту же страницу с новым вопросом
      } else {
        //TODO вызов получения результата
      moveWithHistoryClean(context, new ResultPage());
      }
    }
  }

  void _handleChoice(String value) {
    setState(() {
      _answerUser = value;
    });
  }
}
