import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Опросник Соломина',
      home: new Home(),
    );
  }
}