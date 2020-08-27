import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final double textSize;
  final Color textColor;

  const PageTitle({
    Key key,
    @required this.title,
    this.textSize: 36,
    this.textColor: Colors.black54,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
      ),
    );
  }
}
