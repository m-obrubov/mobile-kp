import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/login.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/question.dart';
import 'package:questionnaire_fe/pages/register.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget bodyButtons;
    var profileIcon;

    if(0 == 0) {
      //authenticated
      bodyButtons = WideRaisedButton(
        onPressed: () => moveWithHistoryClean(context, new Question() /* Страница с вопросами */),
        text: "Начать тест",
        fontSize: 20.0,
      );

      profileIcon = <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () => moveWithHistory(context, null /* new ProfilePage()*/)
        )
      ];
    } else {
      //not authenticated
      bodyButtons = Column(
        children: <Widget>[
          WideRaisedButton(
            onPressed: () => moveWithHistory(context, new LoginPage()),
            text: "Вход",
          ),
          WideRaisedButton(
            onPressed: () => moveWithHistory(context, new RegisterPage()),
            text: "Регистрация",
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
        actions: profileIcon
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'images/logo.png',
                      alignment: Alignment.center,
                      width: 100.0,
                      height: 100.0,
                    ),
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
                      textAlign: TextAlign.justify,
                    ),
                    Divider(),
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
                      textAlign: TextAlign.justify,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            bodyButtons
          ],
        )
      )
    );
  }
}