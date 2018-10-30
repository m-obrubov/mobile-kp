import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Описание",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                ),
                Text(
                  "Анкета 'Ориентация' определяет профессиональную направленность "
                      "личности к определенной сфере деятельности.",
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                Divider()
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Правила",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                  ),
                ),
                Text(
                  "В первой части (\"Я хочу\") вы можете оценить по 4-х бальной"
                      "шкале степень своего желания заниматься...",
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                Divider()
              ],
            ),
            MaterialButton(
              child: Text("Войти"),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
            ),
            MaterialButton(
              child: Text("Зарегистрироваться"),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
            ),
          ],
        ),
      )
    );
  }
}