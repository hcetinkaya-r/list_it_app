import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_it_app/app/sign_in/email_password_login.dart';
import 'package:list_it_app/common_widget/social_login_button.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  void _guestLogin(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    AppUser _appUser = await _userModel.signInAnonymously();
    print("misafir oturumu acan user id: " + _appUser.userID.toString());
  }

  void _signInWithGoogle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    AppUser _appUser = await _userModel.signInWithGoogle();
    if (_appUser != null)
      print("google ile oturum acan user id: " + _appUser.userID.toString());
  }

  void _emailAndPasswordLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailPasswordLoginPage(),
      ),
      /*CupertinoPageRoute ios'ta old ekran gibi sağdan sola açılıyor*/
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List-it",
          style: TextStyle(fontSize: 30),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.black54),
              ),
            ),
            Column(
              children: <Widget>[
                SocialLoginButton(
                  butonText: "Sign in With Email and Password",
                  butonColor: Color(0xFFA30003),
                  butonIcon: Icon(
                    Icons.email,
                    size: 32,
                    color: Colors.white,
                  ),
                  onPressed: () => _emailAndPasswordLogin(context),
                ),
                SocialLoginButton(
                  butonColor: Colors.white,
                  butonText: "Sign in With Google",
                  textColor: Colors.black87,
                  butonIcon: Image.asset("images/google-logo.png"),
                  onPressed: () => _signInWithGoogle(context),
                ),
                SocialLoginButton(
                  butonColor: Color(0xFF334D92),
                  butonText: "Sign in With Facebook",
                  butonIcon: Image.asset("images/facebook-logo.png"),
                  onPressed: () {},
                ),
                SocialLoginButton(
                  butonText: "Guest Login",
                  butonColor: Colors.teal,
                  onPressed: () => _guestLogin(context),
                  butonIcon:
                      Icon(Icons.supervised_user_circle, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
