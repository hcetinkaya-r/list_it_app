import 'package:flutter/material.dart';
import 'package:list_it_app/common_widget/social_login_button.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

class EmailPasswordLoginPage extends StatefulWidget {
  @override
  _EmailPasswordLoginPageState createState() => _EmailPasswordLoginPageState();
}

enum FormType { Register, Login }

class _EmailPasswordLoginPageState extends State<EmailPasswordLoginPage> {
  String _email, _password;
  String _butonText, _linkText;
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    debugPrint("email: " + _email + " sifre: " + _password);
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

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.Login ? "Login" : "Sign in";
    _linkText = _formType == FormType.Login
        ? "Don't have an account? Register"
        : "Do you have an account? Login";

    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.appUser != null) {
      Future.delayed(Duration(milliseconds: 5), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Login/Register"),
          actions: <Widget>[],
        ),
        body: _userModel.state == ViewState.Idle
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            initialValue: "hakan@hakan.com",
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText: _userModel.emailErrorMessage != null
                                  ? _userModel.emailErrorMessage
                                  : null,
                              prefixIcon: Icon(Icons.mail),
                              hintText: "Email",
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (String enteredEmail) {
                              _email = enteredEmail;
                            }),
                        SizedBox(height: 8),
                        TextFormField(
                          initialValue: "123456",
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: _userModel.passwordErrorMessage != null
                                ? _userModel.passwordErrorMessage
                                : null,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Password",
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String enteredPassword) {
                            _password = enteredPassword;
                          },
                        ),
                        SizedBox(height: 8),
                        SocialLoginButton(
                          butonText: _butonText,
                          butonColor: Theme.of(context).primaryColor,
                          radius: 10,
                          onPressed: () => _formSubmit(),
                        ),
                        SizedBox(height: 10),
                        FlatButton(
                          child: Text(_linkText),
                          onPressed: () => _changeState(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
