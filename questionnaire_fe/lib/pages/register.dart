import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/home.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _surname;
  int _age;
  String _city;
  String _email;
  String _password;
  var _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
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
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onFieldSubmitted: (val) => _name = val,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Фамилия"),
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onFieldSubmitted: (val) => _surname = val,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Возраст"),
                  keyboardType: TextInputType.number,
                  validator: _emptyFieldValidator,
                  onFieldSubmitted: (val) => _age = val as int,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Город"),
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onFieldSubmitted: (val) => _city = val,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Адрес электронной почты"),
                  keyboardType: TextInputType.emailAddress,
                  validator: _emptyFieldValidator,
                  onFieldSubmitted: (val) => _email = val,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Пароль"),
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onFieldSubmitted: (val) => _password = val,
                  obscureText: true,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Повторите пароль"),
                  keyboardType: TextInputType.text,
                  validator: _repeatPasswordValidator,
                  obscureText: true,
                ),
                Text(
                  "Пол:",
                  style: TextStyle(fontSize: 18.0),
                ),
                Container(
                  padding: EdgeInsets.only(left: 2.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio<String>(
                            value: 'MALE',
                            groupValue: _gender,
                            onChanged: _handleGenderChoice,
                          ),
                          Text("Мужской"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio<String>(
                            value: 'FEMALE',
                            groupValue: _gender,
                            onChanged: _handleGenderChoice,
                          ),
                          Text("Женский"),
                        ],
                      )
                    ],
                  ),
                ),
                WideRaisedButton(
                  onPressed: _submit,
                  text: "Зарегистрироваться",
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      //TODO вызвать API регистрации
      //TODO сбрасывать route
      Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (context) => new Home()));
    }
  }

  String _emptyFieldValidator(val) {
    if(val.isEmpty) {
      return 'Заполните поле';
    } else {
      return '';
    }
  }

  String _repeatPasswordValidator(val) {
    String empty = _emptyFieldValidator(val);
    if(empty != '') {
      return empty;
    }
    if(val != _password) {
      return 'Введите верный пароль';
    }
    return '';
  }

  void _handleGenderChoice(String value) {
    setState(() {
      switch(value) {
        case 'MALE':
          _gender = 'MALE';
          break;
        case 'FEMALE':
          _gender = 'FEMALE';
          break;
      }
    });
  }
}