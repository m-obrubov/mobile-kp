import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/pages/edit_profile.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/result.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  List<ResultTest> results;

  @override
  void initState() {
    // TODO: Вынуть результаты
    results = new List();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => moveWithHistory(context, new EditProfilePage())
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Иван Иванов",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "21 год",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Москва",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) {
                if (i.isOdd) return Divider(height: 12.0);
                final index = i ~/ 2;
                return ListTile(
                  title: Text(
                    _getResultString(results[index])
                  ),
                  //todo вынуть конктретный результат
                  onTap: () => moveWithHistory(context, new ResultPage(results[index])),
                  trailing: Icon(Icons.keyboard_arrow_right),
                );
              },
              itemCount: results.length * 2,
            ),
          )
        ],
      ),
    );
  }

  String _getResultString(ResultTest result) {
      return
        DateFormat('yyyy-MM-dd  kk:mm').format(result.date)+'\n'
          "Хочу: " + "Предмент труда" + result.resultWant.character.value + "Характер труда" + result.resultWant.subject.value + '\n'
          "Могу: " + "Предмент труда" + result.resultCan.character.value + "Характер труда" + result.resultCan.subject.value;
  }

}