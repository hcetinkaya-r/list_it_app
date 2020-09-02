import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:list_it_app/app/app_page/passwords_pages/passwords_home_page.dart';
import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/models/passwords/password.dart';
import 'package:list_it_app/models/passwords/random_string.dart';
import 'package:local_auth/local_auth.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:local_auth/error_codes.dart' as auth_error;

class AddPasswordPage extends StatefulWidget {
  @override
  _AddPasswordPageState createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _registrationNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  var localAuth = LocalAuthentication();

  encrypt.Encrypted encrypted;
  String keyString = "";
  String encryptedString = "";
  String decryptedString = "";
  String masterPassString = "";

  Future<Null> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    masterPassString = masterPass;
  }

  authenticate() async {
    try {
      var localAuth = LocalAuthentication();
      print(await localAuth.getAvailableBiometrics());
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to add new password',
      );

      print(didAuthenticate);

      if (didAuthenticate == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => PasswordsHomePage()),
            (Route<dynamic> route) => false);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Handle this exception here.
      }
    }
  }

  double passwordStrength = 0.0;
  bool obscureText = true;
  String showHide = 'Show Password';
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getMasterPass();

    // authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xFFA30003)),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFFA30003),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Add Password",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 30,
                  ),
                ),
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a title';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Title",
                                  labelStyle: TextStyle(fontFamily: "Subtitle"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              controller: _registrationNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a username';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "User Name/E-mail ",
                                  labelStyle: TextStyle(fontFamily: "Subtitle"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              controller: _userNameController,
                            ),
                          ),
                          TextField(
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              // errorText: 'Please enter valid password',
                              labelText: "Password",
                              labelStyle: TextStyle(fontFamily: "Subtitle"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            controller: _passwordController,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              FlatButton.icon(
                                onPressed: () {
                                  String pass = randomAlphaNumeric(10);
                                  _passwordController.text = pass;
                                },
                                icon: Icon(Icons.security),
                                color: Color(0xFFA30003),
                                textColor: Colors.white,
                                label: Text("Generate Pass"),
                              ),
                              FlatButton.icon(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                    if (obscureText) {
                                      showHide = 'Show Password';
                                    } else {
                                      showHide = 'Hide Password';
                                    }
                                  });
                                },
                                icon: Icon(Icons.slideshow),
                                color: Color(0xFFA30003),
                                textColor: Colors.white,
                                label: Text("Show Password"),
                              ),
                              FlatButton.icon(
                                onPressed: () {
                                  Clipboard.setData(new ClipboardData(
                                      text: _passwordController.text));
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text("Copied to Clipboard"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.content_copy),
                                color: Color(0xFFA30003),
                                textColor: Colors.white,
                                label: Text("Copy Password"),
                              ),
                              SizedBox(height: 130),
                              AppButton(
                                  buttonText: "Add Password",
                                  buttonColor: Color(0xFFA30003),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      encryptPass(_passwordController.text);
                                      Passwords password = Passwords(
                                          registrationName:
                                              _registrationNameController.text,
                                          password: encryptedString,
                                          userName: _userNameController.text);
                                      DatabaseHelper.db.addPassword(password);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PasswordsHomePage()),
                                          (Route<dynamic> route) => false);
                                    }
                                  }),
                              /*RedLargeButton(
                                buttonText: "Add Password",
                                buttonTextColor: Colors.white,
                                buttonFontSize: 20,
                                buttonColor: Color(0xFFA30003),
                                buttonRadius: 16,
                                buttonOnPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    encryptPass(_passwordController.text);
                                    Passwords password = Passwords(
                                        registrationName:
                                            _registrationNameController.text,
                                        password: encryptedString,
                                        userName: _userNameController.text);
                                    DatabaseHelper.db.addPassword(password);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PasswordsHomePage()),
                                        (Route<dynamic> route) => false);
                                  }
                                },
                              ),*/
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: 10,
            child: PageAvatar(
              avatarIcon: Icons.security,
            ),
          ),
        ],
      ),
    );
  }

  void encryptPass(String text) {
    keyString = masterPassString;
    if (keyString.length < 32) {
      int count = 32 - keyString.length;
      for (var i = 0; i < count; i++) {
        keyString += ".";
      }
    }
    final key = encrypt.Key.fromUtf8(keyString);
    final plainText = text;
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final e = encrypter.encrypt(plainText, iv: iv);
    encryptedString = e.base64.toString();
  }
}
