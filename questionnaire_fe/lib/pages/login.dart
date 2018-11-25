import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/home.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _login;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Адрес электронной почты"),
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
                onSaved: (val) { _login = val; },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Пароль"),
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: _emptyFieldValidator,
                onSaved: (val) { _password = val; },
              ),
              WideRaisedButton(
                onPressed: _submit,
                text: "Войти",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      AuthService.auth(_login, _password);
      moveWithHistoryClean(context, new Home());
    }
  }

  String _emptyFieldValidator(String val) {
    if(val.isEmpty) {
      return 'Заполните поле';
    } else {
      return null;
    }
  }

  String _emailValidator(String val) {
    String empty = _emptyFieldValidator(val);
    if(empty != null) {
      return empty;
    }

    String exp = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(exp);
    if (!regExp.hasMatch(val)) {
      return "Введите корректный адрес электронной почты";
    }

    return null;
  }
}