import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_it_app/common_widget/sensitive_platform_widget.dart';

class SensitivePlatformAlertDialog extends SensitivePlatformWidget {
  final String title;
  final String content;
  final String rightButtonText;
  final String leftButtonText;

  SensitivePlatformAlertDialog(
      {@required this.title,
      @required this.content,
      @required this.rightButtonText,
      this.leftButtonText});

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
        context: context, builder: (context) => this)
        : await showDialog<bool>(
      context: context,
      builder: (context) => this,
      barrierDismissible: false,
    );
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _setDialogButton(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _setDialogButton(context),
    );
  }

  List<Widget> _setDialogButton(BuildContext context) {
    final allButtons = <Widget>[];

    if (Platform.isIOS) {
      if (leftButtonText != null) {
        allButtons.add(
          CupertinoDialogAction(
            child: Text(leftButtonText),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      allButtons.add(
        CupertinoDialogAction(
          child: Text(rightButtonText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (leftButtonText != null) {
        allButtons.add(
          FlatButton(
            child: Text(leftButtonText),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      allButtons.add(
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    }

    return allButtons;
  }
}
