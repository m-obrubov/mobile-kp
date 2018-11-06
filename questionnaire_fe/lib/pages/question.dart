import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/testHome.dart';

class Question extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RegisterPageState();

}

class RegisterPageState extends State<StatefulWidget> {
  String _question; // TODO текуший вопрос!
  List<String> _answer; // TODO
  int _countQuestion; //Общее кол-во вопросов

  var _answerUser; // TODO

  RegisterPageState() {
    this._question = "Что тебе сейчас необходимо?";
    List<String> list = new List();
    list.add("Чай");
    list.add("Еще чай!");
    list.add("Печеньки");
    this._answer = list;
    _countQuestion = 40;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Вопрос 30 из $_countQuestion"),
        ),
        body: SingleChildScrollView(
            child: Container(

              padding: EdgeInsets.only(left: 2.0),
              child: Column(
                children: <Widget>[
                  Text(
                    _question,
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                  // TODO тут дожен появиться цикл
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: _answer[0],
                        groupValue: _answerUser,
                        onChanged: _handleChoice,
                      ),
                      Text(
                        _answer[0],
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: _answer[1],
                        groupValue: _answerUser,
                        onChanged: _handleChoice,
                      ),
                      Text(
                        _answer[1],
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: _answer[2],
                        groupValue: _answerUser,
                        onChanged: _handleChoice,
                      ),
                      Text(
                          _answer[2],
                          style: TextStyle(
                              fontSize: 18.0
                          ),
                      ),
                    ],
                  ),
                  RaisedButton( // TODO у МАКСА есть класс кнопки!
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Ответить",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    color: Theme.of(context).accentColor,
                      onPressed: _event
                  )
                ],
              ),
            )
        )
    );
  }

  //Метод нажатия на кнопку
  void _event(){
    if (_answerUser != null){
      Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (context) => new TestHome()));
    }
  }

  void _handleChoice(String value) {
    setState(() {
      _answerUser = value;
    });
  }
}