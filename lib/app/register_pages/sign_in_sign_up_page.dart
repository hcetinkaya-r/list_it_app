import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:list_it_app/models/hata_exception.dart';
import 'package:list_it_app/app/register_pages/forgot_passoword_page.dart';
import 'package:list_it_app/common_widget/flat_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/sensitive_platform_alert_dialog.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

FirebaseException myError;



class SignInSignUpPage extends StatefulWidget {
  @override
  _SignInSignUpPageState createState() => _SignInSignUpPageState();
}

enum FormType { Register, Login }

class _SignInSignUpPageState extends State<SignInSignUpPage> {
  String _email, _password;
  String _buttonText, _linkText;
  String _textChange;
  var _formType = FormType.Login;
  bool _switchState = false;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    debugPrint("email: " + _email + " password: " + _password);
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_formType == FormType.Login) {
      try {
        AppUser _loggedInAppUser =
            await _userModel.signInWithEmailAndPassword(_email, _password);
        if (_loggedInAppUser != null)
          print("Oturum açan user id: " + _loggedInAppUser.userID.toString());
      } on FirebaseAuthException catch (e) {
        print("OTURUM AÇMA HATA: " + Errors.showError(e.code));
        myError = e;
      }
    } else {
      try {
        AppUser _createdAppUser =
            await _userModel.createUserWithEmailAndPassword(_email, _password);
        if (_createdAppUser != null)
          print("Olusturulan user id: " + _createdAppUser.userID.toString());
      } on FirebaseAuthException catch (e) {
        print("KULLANICI OLUŞTURMA HATA: " + Errors.showError(e.code));
        myError = e;
      }
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

  void _goForgotPasswordPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {



        if (myError != null &&
            myError.code == 'user-not-found') {
          SensitivePlatformAlertDialog(
              title: "SIGN IN ERROR",
              content: Errors.showError(myError.code),
              rightButtonText: "OK")
              .show(context);
        } else if (myError != null && myError.code == 'email-already-in-use') {
          SensitivePlatformAlertDialog(
              title: "SIGN UP ERROR",
              content: Errors.showError(myError.code),
              rightButtonText: "OK")
              .show(context);
        }else if(myError != null && myError.code != null){
          SensitivePlatformAlertDialog(
              title: "SOMETHING WENT WRONG",
              content: Errors.showError(myError.code),
              rightButtonText: "OK")
              .show(context);


        }else
          return null;

    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Log in" : "Sign up";
    _linkText = _formType == FormType.Login ? "Sign up" : "Log in";
    _textChange = _formType == FormType.Login
        ? "Don't have an account?"
        : "Do you have an account?";

    final _userModel = Provider.of<UserModel>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                ("images/loginLogo.png"),
                width: 125,
                height: 140,
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30, right: 30, left: 30),
                  height: MediaQuery.of(context).size.height / 1.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                              child: TextFormField(
                                  initialValue: "hakan@hakan.com",
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    errorText:
                                        _userModel.emailErrorMessage != null
                                            ? _userModel.emailErrorMessage
                                            : null,
                                    prefixIcon: Icon(Icons.mail),
                                    hintText: "e-mail",
                                    labelText: "E-mail",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  onSaved: (String enteredEmail) {
                                    _email = enteredEmail;
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: TextFormField(
                                initialValue: "123456",
                                obscureText: true,
                                decoration: InputDecoration(
                                  errorText:
                                      _userModel.passwordErrorMessage != null
                                          ? _userModel.passwordErrorMessage
                                          : null,
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "Password",
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                onSaved: (String enteredPassword) {
                                  _password = enteredPassword;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                              child: AppButton(
                                buttonText: _buttonText,
                                buttonTextSize: 24,
                                onPressed: () => _formSubmit(),
                              ),
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
                                  onPressed: () =>
                                      _goForgotPasswordPage(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: AppButton(
                              buttonColor: Colors.white,
                              buttonText: "Sign in with Google",
                              buttonTextSize: 16,
                              textColor: Colors.black87,
                              buttonIcon: Image.asset("images/google-logo.png"),
                              onPressed: () => _signInWithGoogle(context),
                            ),
                          ),
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
                      )
                    ],
                  ),
                ),
                Positioned(
                    width: MediaQuery.of(context).size.width,
                    child: PageAvatar()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
