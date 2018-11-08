import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/answer.dart';
import 'package:questionnaire_fe/domain/profession.dart';
import 'package:questionnaire_fe/domain/question.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/pages/home.dart';
import 'package:questionnaire_fe/pages/navigation.dart';

class Result extends StatelessWidget {

  ResultTest _result;

  Result(){
    List<Profession> professions = new List();
    professions.add(new Profession("1","Строит дома и не только!","Архитектор"));
    professions.add(new Profession("1","Картиты его конек!","Художник"));
    professions.add(new Profession("1","Что я слышу? Это же музыкант!","Музыкант"));
    professions.add(new Profession("1","Стой! Стой! Стой! Блин ну ты танцор!","Хореограф"));
    String description = "Вы уверенный в себе и амбициозный человек, для вас нет нечего невозможного. Выша жизнь не возможна без творчества!";
    List<Answer> answers1 = new List();
    List<Answer> answers2 = new List();
    List<Answer> answers3 = new List();
    answers1.add(new Answer("4", "Рисовать"));
    answers2.add(new Answer("1", "Семья"));
    answers3.add(new Answer("3", "Очень люблю"));
    List<QuestionWithAnswers> questions = new List();
    questions.add(new QuestionWithAnswers("1",1,"Чего ты хочешь?",answers1));
    questions.add(new QuestionWithAnswers("2",2,"Что для тебя важно?",answers2));
    questions.add(new QuestionWithAnswers("3",3,"Любишь ли ты программировать?",answers3));
    _result = new ResultTest("1",description, professions, questions);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listProfessions  = new List();
    List<Widget> listResultQuestions  = new List();
    Widget widgetProfessions;
    Widget widgetResultQuestions;

    for (int i = 0; i < _result.professions.length; i++) {
      String _professionsDescription = _result.professions[i].description;
      String _professionsName = _result.professions[i].value;
      listProfessions.add (

//        ListTile(
//          title:
//            Text(professions,
//                style: TextStyle(
//                fontSize: 18.0
//                )
//            ),
//         // onTap: () =>  new Text("описание"),
//          trailing: Icon(Icons.keyboard_arrow_right),
//        ),
//            DropdownButton<String>(
//              items: <String>['А', 'B', 'C', 'D'].map((String professions) {
//                return new DropdownMenuItem<String>(
//                  value: professions,
//                  child: new ListTile(
//                    title: Text(professions),
//                  ),
//                );
//              }).toList(),
//              onChanged: (_) {},
//            ),
          DropdownButton<String>(
            items: <String>[_professionsName,_professionsDescription].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            value: _professionsName,
            isExpanded: true,
            //style: TextStyle( fontSize: 13),
            onChanged: (_) {},
          )
      );
    }

    for (int i = 0; i < _result.QuestionWithAnswersUser.length; i++) {
      String  question = _result.QuestionWithAnswersUser[i].value;
      String  answer = _result.QuestionWithAnswersUser[i].answer[0].value;
      listResultQuestions.add (
          ListTile(
            title:
            Text(question,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0
                )
            ),
          ),
      );
      listResultQuestions.add (
        ListTile(
          title:
          Text("  " + answer,
              style: TextStyle(
                  fontSize: 18.0,
              )
          ),
        ),
      );
    }

    widgetProfessions = new Column(children: listProfessions);
    widgetResultQuestions = new Column(children: listResultQuestions);

    var profileIcon;
      profileIcon = <Widget>[
        IconButton(
            icon: Icon(Icons.check),
            onPressed: () => moveWithHistory(context, new Home())
        )
      ];
      //not authenticate


    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.accessibility),text: "Результаты",),
                      Tab(icon: Icon(Icons.assignment_turned_in),text: "Мои ответы",)
                    ],
                  ),
                title: Text('Страница результата'),
                actions: profileIcon,
              ),
              body: TabBarView(children: [
            SingleChildScrollView(
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
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  widgetResultQuestions,
                ],
              ),
            )
        ])
    )
    )
    );


  }
}