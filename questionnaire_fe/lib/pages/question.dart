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
  int _numberCurrentQuestion;
  Question _currentQuestion; //текущий вопрос
  var _answerUser; // ответ пользователя
  List<QuestionWithAnswers> _questionsWithAnswers; //Список ответов на вопросы пользователя
  List<Answer> _answer; //

  bool _loadingInProgress = false;

  _QuestionPageState(){
    _questionsWithAnswers = new List();
  }

  @override
  void initState() {
    _numberCurrentQuestion = 0;
    _test = DataProvider.getTestFromStorage();
    _test.questions.sort((o1,o2) => o1.numberInOrder.compareTo(o2.numberInOrder));
    _test.answers.sort((o1,o2) => o1.id.compareTo(o2.id));
    _countQuestion = _test.questions.length;
    _answer = _test.answers;
    _currentQuestion = _test.questions[_numberCurrentQuestion];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listRadioListTile  = new List();
    Widget widgetRadioListTile;
    for (int i = 0; i < _answer.length; i++) {
      Answer answer = _answer[i];
      listRadioListTile.add (RadioListTile<int>(
        value: answer.id,
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
    String textButton;
    if (_currentQuestion.numberInOrder != _countQuestion){
      textButton = "Ответить";
    } else {
      textButton = "Завершить тестирование";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Вопрос " + _currentQuestion.numberInOrder.toString() + " из " + _countQuestion.toString() + "."),
      ),
        body: _loadingInProgress ? _getSpinner() : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 2.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                        "\n" + _currentQuestion.value + "\n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                        )
                    ),
                  ),
                  widgetRadioListTile,
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: WideRaisedButton(
                        text: textButton,
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
      List<Answer> answer = new List();
      answer.add(Answer(_answerUser)); //заворачиваем ответ пользователя
      _questionsWithAnswers.add(new QuestionWithAnswers(_currentQuestion.id,answer));
      if (_currentQuestion.numberInOrder != _countQuestion) {
        setState(() {
          _answerUser = null;
          _currentQuestion = _test.questions[++_numberCurrentQuestion];
        });
      } else {
        setState(() {
          _loadingInProgress = true;
        });
        DataProvider.getResult(_questionsWithAnswers,_test.id).then((res) {
          if (res != null) {
            moveWithHistoryClean(context, new ResultPage(res, true));
          } else {
            _showError("Ошибка. Обратитесь в службу поддержки!");
          }
        });
      }
    } else {
      _showError("Ответ на вопрос обязателен!");
    }
  }

  void _handleChoice(int value) {
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
