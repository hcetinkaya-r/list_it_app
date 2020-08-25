import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:list_it_app/sign_in_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => SignInPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var center = Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/splash_logo.png"), fit: BoxFit.contain),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: center,
    );
  }
}
