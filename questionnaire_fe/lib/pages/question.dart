import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/answer.dart';
import 'package:questionnaire_fe/domain/question.dart';
import 'package:questionnaire_fe/domain/test.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/exception_handler.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/result.dart';
import 'package:questionnaire_fe/services/requester.dart';

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

  bool _loadingInProgress = false;

  _QuestionPageState();

  @override
  void initState() {
    // TODO: достать тест
    _test = DataProvider.getTestFromStorage();
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
          //TODO условие
          title: Text("Вопрос " + _currentQuestion.numberInOrder.toString() + " из " + _countQuestion.toString() + "."),
        ),
        body: _loadingInProgress ? _getSpinner() : SingleChildScrollView(
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

  Widget _getSpinner() => new Center(child: CircularProgressIndicator());

  void _submit() {
    if (_answerUser != null) {
      List<Answer> answer = new List(1);
      answer.add(Answer(_answerUser)); //заворачиваем ответ пользователя
      _questionsWithAnswers.add(new QuestionWithAnswers(_currentQuestion.id,answer));
      if (_currentQuestion.numberInOrder != _countQuestion) {
        //TODO вызвать переход на эту же страницу с новым вопросом
      } else {
        setState(() {
          _loadingInProgress = true;
        });
        DataProvider.getResult(_questionsWithAnswers).then((res) {
          if (res != null) {
            moveWithHistoryClean(context, new ResultPage(res));
          } else {
            _showError("Ошибка. Обратитесь в служду подержки!");
          }
        });
      }
    }
  }

  void _handleChoice(String value) {
    setState(() {
      _answerUser = value;
    });
  }

  void _showError(String text) {
    setState(() {
      _loadingInProgress = false;
    });
    errorDialog(context, text);
  }

}
