import 'package:flutter/material.dart';



void moveWithHistory(BuildContext context, Widget widget) {
  Navigator
      .of(context)
      .push(MaterialPageRoute(builder: (context) => widget));
}

void moveWithHistoryClean(BuildContext context, Widget widget) {
  Navigator
      .of(context)
      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), (Route<dynamic> route) => route.settings.isInitialRoute);
}