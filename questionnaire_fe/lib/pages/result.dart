import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/pages/home.dart';
import 'package:questionnaire_fe/pages/navigation.dart';

class ResultPage extends StatefulWidget {

  final ResultTest _result;
  final bool _hasCheck;

  ResultPage(this._result, this._hasCheck);

  @override
  State<StatefulWidget> createState() => new _ResultPage(_result, _hasCheck);

}

class _ResultPage extends State<ResultPage> with SingleTickerProviderStateMixin {

  final ResultTest _result;
  final bool _hasCheck;
  TabController _tabController;

  _ResultPage(this._result, this._hasCheck);


  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> listResultQuestions  = new List();

    List<Widget> listProfessionsWant  = new List();
    List<Widget> listProfessionsCan  = new List();
    Widget widgetProfessionsWant;
    Widget widgetProfessionsCan;
    Widget widgetResultQuestions;

    for (int i = 0; i < _result.resultWant.professions.length; i++) {
      String _professionsDescription = _result.resultWant.professions[i].description;
      String _professionsName = _result.resultWant.professions[i].value;
      listProfessionsWant.add (
          DropdownButton<String>(
            items: <String>[_professionsName,_professionsDescription].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            value: _professionsName,
            isExpanded: true,
            onChanged: (_) {},
          )
      );
    }

    for (int i = 0; i < _result.resultCan.professions.length; i++) {
      String _professionsDescription = _result.resultCan.professions[i].description;
      String _professionsName = _result.resultCan.professions[i].value;
      listProfessionsCan.add (
          DropdownButton<String>(
            items: <String>[_professionsName,_professionsDescription].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            value: _professionsName,
            isExpanded: true,
            onChanged: (_) {},
          )
      );
    }

    for (int i = 0; i < _result.questionWithAnswersUser.length; i++) {
      String  question = _result.questionWithAnswersUser[i].value;
      String  answer = _result.questionWithAnswersUser[i].answer[0].value;
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
          leading: Icon(Icons.check_box),
          title:
          Text(answer,
              style: TextStyle(
                fontSize: 18.0,
              )
          ),
        ),
      );
    }

    widgetProfessionsCan = new Column(children: listProfessionsCan);
    widgetProfessionsWant = new Column(children: listProfessionsWant);
    widgetResultQuestions = new Column(children: listResultQuestions);

    //not authenticate
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.accessibility),text: "Результаты",),
              Tab(icon: Icon(Icons.assignment_turned_in),text: "Мои ответы",)
            ],
            controller: _tabController,
          ),
          title: Text('Страница результата'),
          actions: _hasCheck ? [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => moveWithHistory(context, new HomePage())
            )
          ] : []
        ),
        body: TabBarView(
            controller: _tabController,
            children: [
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
                      '\nРезультат тестирования\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0

                      ),
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                    Text(
                      'Умение: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Предмет труда: ' + _result.resultWant.character.title + '\n'
                          'Характер труда: ' + _result.resultWant.subject.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '\n' + _result.resultWant.description + '\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(),
                    Text(
                      '\nСписок профессий, подходящих вам:\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    widgetProfessionsWant,
                    Text(
                      'Желание: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Предмет труда: ' + _result.resultCan.character.title + '\n'
                          'Характер труда: ' + _result.resultCan.subject.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '\n' + _result.resultCan.description + '\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(),
                    Text(
                      '\nСписок профессий, подходящих вам:\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    widgetProfessionsCan,
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "\nТест пройден: " + DateFormat('yyyy-MM-dd   kk:mm').format(_result.date) + "\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    widgetResultQuestions,
                  ],
                ),
              )
            ]
        )
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}