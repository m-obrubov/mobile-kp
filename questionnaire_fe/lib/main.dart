import 'package:flutter/material.dart';
import 'package:questionnaire_fe/domain/test.dart';
import 'package:questionnaire_fe/pages/home.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:questionnaire_fe/services/requester.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:questionnaire_fe/services/requester.dart' as requester;

void main() {
  SharedPreferences.getInstance().then((prefs) {
    requester.prefs = prefs;
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging;
  Test _test;

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
    DataProvider.dropTestStore();
    return new MaterialApp(
      title: 'Опросник Соломина',
      home: new HomePage(),
    );
  }
}