import 'package:flutter/material.dart';
import 'dart:io';

abstract class SensitivePlatformWidget extends StatelessWidget {
  Widget buildAndroidWidget(BuildContext context);

  Widget buildIOSWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildIOSWidget(context);
    }else{
      return buildAndroidWidget(context);
    }

  }
}
