import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/constants.dart';
import 'package:questionnaire_fe/domain/test.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/filters.dart';
import 'package:questionnaire_fe/pages/login.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/question.dart';
import 'package:questionnaire_fe/pages/register.dart';
import 'package:questionnaire_fe/pages/profile.dart';
import 'package:questionnaire_fe/services/requester.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> {

  bool _isAuthenticated = false;
  Role _role;
  Test _test;

  @override
  void initState() {
    _test = DataProvider.getTestFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isAuthenticated = AuthService.isAuthenticated();
    if(_isAuthenticated) {
      _role = AuthService.getRole();
    }
    var profileIcon;
    Widget exitButton;
    if(_isAuthenticated) {
      if(_role == Role.STUDENT) {
        profileIcon = <Widget>[
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () => moveWithHistory(context, new ProfilePage())
          )
        ];
      }

      exitButton = IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Выход'),
                  content: Text('Вы точно хотите выйти?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Да',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      onPressed: () {
                        setState(() {
                          AuthService.logout();
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Нет',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
        leading: exitButton,
        actions: profileIcon
      ),
      body: _getNormalScreen()
    );
  }

  Widget _getNormalScreen() {
    Widget bodyButtons;
    if(_isAuthenticated) {
      if(_role == Role.STUDENT) {
        bodyButtons = WideRaisedButton(
            onPressed: () => moveWithHistoryClean(context, new QuestionPage()),
            text: "Начать тест",
        );
      } else {
        bodyButtons = WideRaisedButton(
          onPressed: () => moveWithHistory(context, new StatisticsFilterPage()),
          color: Colors.lightGreen,
          text: "Статистика",
        );
      }
    } else {
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

    return Column(
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
                  _test.about,
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
                  _test.rules,
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
        Container(
          padding: EdgeInsets.all(16.0),
          child: bodyButtons,
        )
      ],
    );
  }
}