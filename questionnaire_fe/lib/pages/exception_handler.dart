import 'package:flutter/material.dart';

Future<void> errorDialog(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ошибка'),
        content: Text(text),
        actions: <Widget>[
          FlatButton(
            child: Text('ОК'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}