import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/login.dart';
import 'package:questionnaire_fe/pages/register.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Описание",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                ),
                Text(
                  "Анкета 'Ориентация' определяет профессиональную направленность "
                      "личности к определенной сфере деятельности.",
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                Divider()
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Правила",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                  ),
                ),
                Text(
                  "В первой части (\"Я хочу\") вы можете оценить по 4-х бальной"
                      "шкале степень своего желания заниматься...",
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                Divider()
              ],
            ),
            WideRaisedButton(
              onPressed: () =>
                  Navigator
                      .of(context)
                      .push(MaterialPageRoute(builder: (context) => new LoginPage())),
              text: "Вход",
            ),
            WideRaisedButton(
              onPressed: () =>
                  Navigator
                      .of(context)
                      .push(MaterialPageRoute(builder: (context) => new RegisterPage())),
              text: "Регистрация",
            ),
          ],
        ),
      )
    );
  }
}