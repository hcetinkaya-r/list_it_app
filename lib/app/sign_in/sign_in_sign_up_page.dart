import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_it_app/common_widget/flat_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/sign_in_button.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

class SignInSignUpPage extends StatefulWidget {
  @override
  _SignInSignUpPageState createState() => _SignInSignUpPageState();
}

enum FormType { Register, Login }

class _SignInSignUpPageState extends State<SignInSignUpPage> {
  String _email, _password;
  String _butonText, _linkText;
  String _textChange;
  var _formType = FormType.Login;
  bool _switchState = false;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    debugPrint("email: " + _email + " password: " + _password);
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_formType == FormType.Login) {
      AppUser _loggedInAppUser =
          await _userModel.signInWithEmailAndPassword(_email, _password);
      if (_loggedInAppUser != null)
        print("Oturum açan user id: " + _loggedInAppUser.userID.toString());
    } else {
      AppUser _createdAppUser =
          await _userModel.createUserWithEmailAndPassword(_email, _password);
      if (_createdAppUser != null)
        print("Olusturulan user id: " + _createdAppUser.userID.toString());
    }
  }

  void _changeState() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;

    });
  }

  /*void _guestLogin(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    AppUser _appUser = await _userModel.signInAnonymously();
    print("misafir oturumu acan user id: " + _appUser.userID.toString());
  }*/

  void _signInWithGoogle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    AppUser _appUser = await _userModel.signInWithGoogle();
    if (_appUser != null)
      print("google ile oturum acan user id: " + _appUser.userID.toString());
  }



  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.Login ? "Log in" : "Sign up";
    _linkText = _formType == FormType.Login ? "Sign up" : "Log in";
    _textChange = _formType == FormType.Login ? "Don't have an account?" : "Do you have an account?";


    final _userModel = Provider.of<UserModel>(context);


    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ("images/loginLogo.png"),
                  width: 125,
                  height: 140,
                ),
                Container(
                  margin: EdgeInsets.only(right: 30, left: 30),
                  height: MediaQuery.of(context).size.height / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(height: 60),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: TextFormField(
                                      initialValue: "hakan@hakan.com",
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        errorText:
                                            _userModel.emailErrorMessage != null
                                                ? _userModel.emailErrorMessage
                                                : null,
                                        prefixIcon: Icon(Icons.mail),
                                        hintText: "Email",
                                        labelText: "Email",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      onSaved: (String enteredEmail) {
                                        _email = enteredEmail;
                                      }),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: TextFormField(
                                    initialValue: "123456",
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      errorText:
                                          _userModel.passwordErrorMessage !=
                                                  null
                                              ? _userModel.passwordErrorMessage
                                              : null,
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: "Password",
                                      labelText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    onSaved: (String enteredPassword) {
                                      _password = enteredPassword;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            SignInButton(
                              buttonText: _butonText,
                              buttonTextSize: 24,
                              onPressed: () => _formSubmit(),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Switch(
                                  onChanged: (value) {
                                    setState(() {
                                      _switchState = value;
                                    });
                                  },
                                  activeColor: Colors.green,
                                  value: _switchState,
                                ),
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                AppFlatButton(
                                  buttonTextColor: Colors.grey.shade600,
                                  buttonText: "Forgot Password?",
                                  buttonTextWeight: FontWeight.bold,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SignInButton(
                                buttonColor: Colors.white,
                                buttonText: "Sign in With Google",
                                buttonTextSize: 16,
                                textColor: Colors.black87,
                                buttonIcon:
                                    Image.asset("images/google-logo.png"),
                                onPressed: () => _signInWithGoogle(context),
                              ),
                            ),

                            /*SocialLoginButton(
                                  buttonText: "Guest Login",
                                  onPressed: () => _guestLogin(context),
                                  buttonIcon: Icon(Icons.supervised_user_circle,
                                      color: Colors.white),
                                ),*/
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            _textChange,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          AppFlatButton(
                            buttonText: _linkText,
                            buttonTextColor: Color(0xFFA30003),
                            buttonTextWeight: FontWeight.bold,
                            onPressed: () => _changeState(),
                          ),
                          Container(
                            alignment: Alignment.center,
                            color: Color(0xFFA30003),
                            height: 20,
                            child: Text(
                              "OR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  "images/facebook.png",
                                  width: MediaQuery.of(context).size.width / 9,
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                ),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  "images/pinterest.png",
                                  width: MediaQuery.of(context).size.width / 9,
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                ),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  "images/instagram.png",
                                  width: MediaQuery.of(context).size.width / 9,
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: MediaQuery.of(context).size.height / 6,
                left: MediaQuery.of(context).size.width / 2.37,
                child: PageAvatar()),
          ],
        ),
      ),
    );
  }
}