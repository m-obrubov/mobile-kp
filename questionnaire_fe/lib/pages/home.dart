import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/filters.dart';
import 'package:questionnaire_fe/pages/login.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/profile.dart';
import 'package:questionnaire_fe/pages/register.dart';
import 'package:questionnaire_fe/pages/statistics.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget bodyButtons;
    var profileIcon;

    if(1 < 2) {
      //authenticated
      bodyButtons = WideRaisedButton(
        onPressed: () => moveWithHistoryClean(context, null /* Страница с вопросами */),
        text: "Начать тест",
        fontSize: 20.0,
      );

      profileIcon = <Widget>[
        IconButton(
            icon: Icon(Icons.warning),
            color: Colors.yellow,
            onPressed: () => moveWithHistory(context, new StatisticsFilterPage())
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () => moveWithHistory(context, new ProfilePage())
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
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
                    "В первой части (\"Я хочу\") вы можете оценить по 4-х балльной "
                        "шкале степень своего желания заниматься...",
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: bodyButtons,
          )
        ],
      )
    );
  }
}