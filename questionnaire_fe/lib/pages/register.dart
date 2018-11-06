import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/home.dart';
import 'package:questionnaire_fe/pages/navigation.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _surname;
  int _age;
  String _city;
  String _email;
  TextEditingController _passwordController = new TextEditingController();
  String _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  onSaved: (String val) { _name = val; },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Фамилия"),
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onSaved: (String val) { _surname = val; },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Возраст"),
                  keyboardType: TextInputType.number,
                  validator: _ageValidator,
                  onSaved: (String val) { _age = int.parse(val); },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Город"),
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onSaved: (String val) { _city = val; },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Адрес электронной почты"),
                  keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                  onSaved: (String val) { _email = val; },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Пароль"),
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  obscureText: true,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Повторите пароль"),
                  keyboardType: TextInputType.text,
                  validator: _repeatPasswordValidator,
                  obscureText: true,
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
                      RadioListTile<String>(
                        title: Text("Мужской"),
                        value: 'MALE',
                        groupValue: _gender,
                        onChanged: (value) { setState(() { _gender = value; }); },
                      ),
                      RadioListTile<String>(
                        title: Text("Женский"),
                        value: 'FEMALE',
                        groupValue: _gender,
                        onChanged: (value) { setState(() { _gender = value; }); },
                      ),
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
    final form = _formKey.currentState;
    if (form.validate()) {
      //валидация Radio
      if(_gender == null) {
        //высплывающее окно
        final snackBar = new SnackBar(
          content: new Text('Выберите пол'),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      form.save();
      //TODO вызвать API регистрации
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

  String _repeatPasswordValidator(String val) {
    String empty = _emptyFieldValidator(val);
    if(empty != null) {
      return empty;
    }
    if(val != _passwordController.text) {
      return 'Пароли не совпадают';
    }
    return null;
  }

  String _ageValidator(String val) {
    String empty = _emptyFieldValidator(val);
    if(empty != null) {
      return empty;
    }

    int age = double.parse(val).round();
    if(age <= 0 && age > 100) {
      return 'Введите корректный возраст';
    }

    return null;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}