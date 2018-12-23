import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/constants.dart';
import 'package:questionnaire_fe/domain/user.dart';
import 'package:questionnaire_fe/exception/exceptions.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/exception_handler.dart';
import 'package:questionnaire_fe/services/requester.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new EditProfilePageState(user);
}

class EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  User _user;
  String _name;
  String _surname;
  int _age;
  String _city;
  Gender _gender;

  EditProfilePageState(this._user) {
    _gender = _user.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Изменение профиля'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Имя"),
                  initialValue: _user.firstName,
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onSaved: (String val) { _name = val; },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Фамилия"),
                  initialValue: _user.lastName,
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onSaved: (String val) { _surname = val; },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Возраст"),
                  initialValue: _user.age.toString(),
                  keyboardType: TextInputType.number,
                  validator: _ageValidator,
                  onSaved: (String val) { _age = int.parse(val); },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Город"),
                  initialValue: _user.city,
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onSaved: (String val) { _city = val; },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  "Пол:",
                  style: TextStyle(fontSize: 18.0),
                ),
                Container(
                  padding: EdgeInsets.only(left: 2.0),
                  child: Column(
                    children: <Widget>[
                      RadioListTile<Gender>(
                        title: Text(Gender.MALE.title),
                        value: Gender.MALE,
                        groupValue: _gender,
                        onChanged: (value) { setState(() { _gender = value; }); },
                      ),
                      RadioListTile<Gender>(
                        title: Text(Gender.FEMALE.title),
                        value: Gender.FEMALE,
                        groupValue: _gender,
                        onChanged: (value) { setState(() { _gender = value; }); },
                      ),
                    ],
                  ),
                ),
                WideRaisedButton(
                  onPressed: _submit,
                  text: "Изменить данные",
                ),
              ],
            ),
          ),
        )
      )
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      User user = new User(
        firstName: _name,
        lastName: _surname,
        age: _age,
        city: _city,
        gender: _gender
      );
      DataProvider.updateUserData(user).then((res) {
        if(res) {
          Navigator.of(context).pop();
        }
      }).catchError((RestCallException e) => _showError(e.getMessage()));
    }
  }

  String _emptyFieldValidator(String val) {
    if(val.isEmpty) {
      return 'Заполните поле';
    } else {
      return null;
    }
  }

  String _ageValidator(String val) {
    String empty = _emptyFieldValidator(val);
    if(empty != null) {
      return empty;
    }

    int age = double.parse(val).round();
    if(age <= 0 || age > 100) {
      return 'Введите корректный возраст';
    }

    return null;
  }

  void _showError(String text) {
    errorDialog(context, text);
  }
}