import 'package:flutter/material.dart';

class WideRaisedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final Color textColor;

  const WideRaisedButton({
    @required this.onPressed,
    this.text,
    this.fontSize = 16.0,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
      color: Theme.of(context).accentColor,
      textColor: textColor,
    );
  }
}