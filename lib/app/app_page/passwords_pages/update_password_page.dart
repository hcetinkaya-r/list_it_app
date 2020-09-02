
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/models/passwords/password.dart';
import 'package:list_it_app/models/passwords/passwords_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class UpdatePasswordPage extends StatefulWidget {
  final Passwords password;

  const UpdatePasswordPage({Key key, this.password}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState(password);
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {

  _UpdatePasswordPageState(this.password);
  final Passwords password;
  final _formKey = GlobalKey<FormState>();
  final bloc = PasswordsBloc();




  TextEditingController _masterPassController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _registrationNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool decrypt = false;
  String decrypted = "";
  int index;
  bool didAuthenticate = false;

  authenticate() async {
    var localAuth = LocalAuthentication();

    didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to view password',
        stickyAuth: true);
  }

  Future<String> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    return masterPass;
  }

  @override
  void initState() {
    authenticate();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
            height: double.infinity,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  child: Text(
                    "Update Password",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(

                          decoration: InputDecoration(
                              labelText: "Title",
                              labelStyle: TextStyle(fontFamily: "Subtitle"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(

                          decoration: InputDecoration(
                              labelText: "User Name/E-mail",
                              labelStyle: TextStyle(fontFamily: "Subtitle"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),

                        ),
                      ),
                      Padding(

                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(

                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(fontFamily: "Subtitle"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),

                        ),
                      )


                    ],
                  ),
                ),
                FlatButton.icon(
                  textColor: Colors.white,
                  color: Color(0xFFA30003),
                  onPressed: () async {
                    if (!decrypt && !didAuthenticate) {
                      buildShowDialogBox(context);
                    } else if (!decrypt && didAuthenticate) {
                      String masterPass = await getMasterPass();
                      decryptPass(password.password, masterPass);
                    } else if (decrypt) {
                      setState(() {
                        decrypt = !decrypt;
                      });
                    }
                  },
                  icon: decrypt ? Icon(Icons.lock_open) : Icon(Icons.lock),
                  label: Text(
                    "Enter master password to unlock",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: 10,
              child: PageAvatar(
                avatarIcon: Icons.security,
              )),
        ],
      ),
    );
  }

  Future buildShowDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Enter Master Password",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFA30003),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "To decrypt the password enter your master password:",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Subtitle'),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                maxLength: 32,
                decoration: InputDecoration(
                    hintText: "Master Password",
                    hintStyle: TextStyle(fontFamily: "Subtitle"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _masterPassController,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              color: Color(0xFFA30003),
              onPressed: () {
                Navigator.of(context).pop();
                decryptPass(
                    password.password, _masterPassController.text.trim());
                _masterPassController.clear();
                if (!decrypt) {
                  final snackBar = SnackBar(
                    content: Text(
                      'Wrong Master Password',
                      style: TextStyle(fontFamily: "Subtitle"),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackBar);
                }
              },
              child: Text("Verify Your Master Password"),
            ),
          ],
        );
      },
    );
  }

  decryptPass(String encryptedPass, String masterPass) {
    String keyString = masterPass;
    if (keyString.length < 32) {
      int count = 32 - keyString.length;
      for (var i = 0; i < count; i++) {
        keyString += ".";
      }
    }

    final iv = encrypt.IV.fromLength(16);
    final key = encrypt.Key.fromUtf8(keyString);

    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final d = encrypter.decrypt64(encryptedPass, iv: iv);
      setState(() {
        decrypted = d;
        decrypt = true;
      });
    } catch (exception) {
      setState(() {
        decrypted = "Wrong Master Password";
      });
    }
  }
}
