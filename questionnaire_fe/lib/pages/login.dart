import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/home.dart';

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
                keyboardType: TextInputType.text,
                validator: _emptyFieldValidator,
                onFieldSubmitted: (val) => _login = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Пароль"),
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: _emptyFieldValidator,
                onFieldSubmitted: (val) => _password = val,
              ),

              RaisedButton(
                onPressed: _submit,
                child: Text(
                  "Войти",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _emptyFieldValidator(val) {
    if(val.isEmpty) {
      return 'Заполните поле';
    } else {
      return '';
    }
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      //TODO вызвать API получения токена
      //TODO сбрасывать route
      Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (context) => new Home()));
    }
  }
}