import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/pages/navigation.dart';

class Result extends StatelessWidget {

  ResultTest _result;

  Result(){
    List<String> list = new List();
    list.add("Архитектор");
    list.add("Художник");
    list.add("Музыкант");
    list.add("Хореограф");
    String description = "Вы уверенный в себе и амбициозный человек, для вас нет нечего невозможного. Выша жизнь не возможна без творчества!";
    _result = new ResultTest("1",description, list);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listProfessions  = new List();
    Widget widgetProfessions;

    for (int i = 0; i < _result.professions.length; i++) {
      String professions = _result.professions[i];
      listProfessions.add (
        ListTile(
          title:
            Text(professions,
                style: TextStyle(
                fontSize: 18.0
                )
            ),
          onTap: () => moveWithHistory(context, null /* Страница с результатами*/),
          trailing: Icon(Icons.keyboard_arrow_right),
        )
      );
    }
    widgetProfessions = new Column(children: listProfessions);

    var profileIcon;
      profileIcon = <Widget>[
        IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => moveWithHistory(context, null /* new ProfilePage()*/)
        )
      ];
      //not authenticate

    return Scaffold(
        appBar: AppBar(
            title: Text('Страница результата'),
            actions: profileIcon
        ),
        body: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/logo.png',
                      alignment: Alignment.center,
                      width: 100.0,
                      height: 100.0,
                    ),
                    Text(
              '\nПоздравлю вы завершили тестирование!\n',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0
              ),
            ),
            Divider(),
            Text(
              "\n" + _result.description + "\n",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
            Divider(),
            Text(
              "\nСписок профессий подходящих вам:\n",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
            widgetProfessions,
            ],
          ),
        )
    );
  }
}