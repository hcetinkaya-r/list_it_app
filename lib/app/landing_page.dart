import 'package:flutter/material.dart';
import 'package:list_it_app/app/home_page.dart';
import 'package:list_it_app/app/sign_in/sign_in_sign_up_page.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.state == ViewState.Idle) {
      if (_userModel.appUser == null) {
        return SignInSignUpPage();
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
