import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/answer.dart';
import 'package:questionnaire_fe/domain/question.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/result.dart';

class Question extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RegisterPageState();

}

class RegisterPageState extends State<StatefulWidget> {
  int _countQuestion; //Общее кол-во вопросов

  QuestionWithAnswers _question;
  var _answerUser; // ответ пользователя

  RegisterPageState() {
    List<Answer> list = new List();
    list.add(new Answer("1", "Спать!"));
    list.add(new Answer("2", "Есть!"));
    list.add(new Answer("3", "Не чего не хочу!"));
    list.add(new Answer("4", "Рисовать"));
    _question = new QuestionWithAnswers("1",1,"Чего ты хочешь?",list);
    _countQuestion = 40;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listRadioListTile  = new List();
    Widget widgetRadioListTile;
    for (int i = 0; i < _question.answer.length; i++) {
      Answer answer = _question.answer[i];
      listRadioListTile.add (RadioListTile<String>(
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Вопрос " + _question.numberInOrder.toString() + " из " + _countQuestion.toString() + "."),
        ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 2.0),
              child: Column(
                children: <Widget>[
                  Text(
                      "\n" + _question.value + "\n",
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
      //TODO вызвать переход на эту же страницу с новым вопросом
      moveWithHistoryClean(context, new Result());
    }
  }

  void _handleChoice(String value) {
    setState(() {
      _answerUser = value;
    });
  }
}
