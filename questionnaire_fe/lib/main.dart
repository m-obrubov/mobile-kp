import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/home.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = new FirebaseMessaging();

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> msg) {
          print('on message $msg');
        });
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registered');
    });
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Опросник Соломина',
      home: new Home(),
    );
  }
}