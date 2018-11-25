import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/button.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _surname;
  int _age;
  String _city;
  String _gender = 'MALE';

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
                  initialValue: 'Иван',
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onSaved: (String val) { _name = val; },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Фамилия"),
                  initialValue: 'Иванов',
                  keyboardType: TextInputType.text,
                  validator: _emptyFieldValidator,
                  onSaved: (String val) { _surname = val; },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Возраст"),
                  initialValue: '21',
                  keyboardType: TextInputType.number,
                  validator: _ageValidator,
                  onSaved: (String val) { _age = int.parse(val); },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Город"),
                  initialValue: 'Москва',
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
      //TODO вызвать API изменения данных
      Navigator
        .of(context)
        .pop();
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
    if(age <= 0 && age > 100) {
      return 'Введите корректный возраст';
    }

    return null;
  }
}