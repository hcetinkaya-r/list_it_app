import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class AppFlatButton extends StatelessWidget {
  final Color buttonTextColor;
  final Color buttonColor;
  final String buttonText;
  final double buttonTextSize;
  final FontWeight buttonTextWeight;
  final VoidCallback onPressed;

  const AppFlatButton({
    Key key,
    this.buttonTextColor,
    this.buttonColor,
    this.buttonText,
    this.buttonTextSize,
    this.buttonTextWeight,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      textColor: buttonTextColor,
      child: Text(buttonText, style: TextStyle(fontSize: buttonTextSize, fontWeight: buttonTextWeight,),),
      onPressed: onPressed,
    );
  }
}
