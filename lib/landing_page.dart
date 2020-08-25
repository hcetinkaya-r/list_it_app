import 'package:flutter/material.dart';
import 'package:list_it_app/home_page.dart';
import 'package:list_it_app/sign_in_page.dart';
import 'package:list_it_app/splash_page.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.state == ViewState.Idle) {
      if (_userModel.appUser == null) {
        return SplashPage();
      } else {
        return HomePage(appUser: _userModel.appUser);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
