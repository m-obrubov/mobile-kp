import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/domain/user.dart';
import 'package:questionnaire_fe/pages/edit_profile.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/result.dart';
import 'package:questionnaire_fe/services/requester.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  User _user;
  List<ResultTest> _results;
  bool _loadingInProgress = true;

  Future<void> _loadData() async {
    _user = await DataProvider.getUserData();
    _results = await DataProvider.getUserResults();
  }

  @override
  Widget build(BuildContext context) {
    _loadData().then((_) {
      setState(() {
        _loadingInProgress = false;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
        actions: _loadingInProgress ? [] : <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => moveWithHistory(context, new EditProfilePage(user: _user))
          )
        ],
      ),
      body: _loadingInProgress ? _getSpinner() : _getNormalBody()
    );
  }

  Widget _getSpinner() => new Center(child: CircularProgressIndicator());

  Widget _getNormalBody() {
    Widget resultList;
    if (_results == null) {
        resultList = Center(child: Text("Результатов ещё нет"));
    } else {
      resultList = Expanded(
        child: ListView.builder(
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider(height: 12.0);
            final index = i ~/ 2;
            return ListTile(
              title: Text(
                  _getResultString(_results[index])
              ),
              onTap: () =>
                  moveWithHistory(context, new ResultPage(_results[index])),
              trailing: Icon(Icons.keyboard_arrow_right),
            );
          },
          itemCount: _results.length * 2,
        ),
      );
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _user != null ? _user.firstName + " " + _user.lastName : "",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                _user != null ? "Лет: " + _user.age.toString() : "",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                _user != null ? "Город: " + _user.city : "",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                _user != null ? "Пол: " + _user.gender.title : "",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        resultList
      ],
    );
  }

  String _getResultString(ResultTest result) {
      return DateFormat('yyyy-MM-dd  kk:mm').format(result.date)+'\n'
          "Хочу: " + "Предмент труда \"" + result.resultWant.character.title + "\", Характер труда \"" + result.resultWant.subject.title + '\"\n'
          "Могу: " + "Предмент труда \"" + result.resultCan.character.title + "\", Характер труда \"" + result.resultCan.subject.title + '\"';
  }

}