import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_it_app/common_widget/social_login_button.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';


class SignInPage extends StatelessWidget {

  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    AppUser _appUser= await _userModel.signInAnonymously();

    print("oturum acan user id: " + _appUser.userID.toString());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("List-it App"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Oturum Açın",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              butonColor: Colors.white,
              butonText: "G-mail ile Oturum Aç",
              textColor: Colors.black87,
              butonIcon: Image.asset("images/google-logo.png"),
              onPressed: () {},
            ),
            SocialLoginButton(
              butonColor: Color(0xFF334D92),
              butonText: "Facebook ile Oturum Aç",
              butonIcon: Image.asset("images/facebook-logo.png"),
              onPressed: () {},
            ),
            SocialLoginButton(
              butonText: "E-mail ve şifre ile Oturum Aç",
              butonIcon: Icon(
                Icons.email,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            SocialLoginButton(
              butonText: "Misafir Girişi",
              butonColor: Colors.teal,
              onPressed: () => _misafirGirisi(context),
              butonIcon:
                  Icon(Icons.supervised_user_circle, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
