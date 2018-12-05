import 'package:flutter/material.dart';
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
  Widget _home = Center(child: CircularProgressIndicator());
  Test _test;

  @override
  Widget build(BuildContext context) {

    _isAuthenticated = AuthService.isAuthenticated();
    _home = _getNormalScreen();

    DataProvider.getTest().then((Test test) {
      setState(() {
        _test = test;
      });
    });
    return _home;
  }

  Widget _getNormalScreen() {
    Widget bodyButtons;
    var profileIcon;
    Widget exitButton;
    if(_isAuthenticated) {
      //authenticated
      bodyButtons = WideRaisedButton(
        onPressed: () => moveWithHistoryClean(context, new QuestionPage() /* Страница с вопросами */),
        text: "Начать тест",
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

      exitButton = IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            setState(() {
              AuthService.logout();
            });
          }
      );
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
            leading: exitButton,
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
                      _test != null ? _test.about : "",
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
                      _test != null ? _test.rules : "",
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