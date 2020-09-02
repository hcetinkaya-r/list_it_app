
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:list_it_app/app/app_page/passwords_pages/update_password_page.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/models/passwords/password.dart';
import 'package:local_auth/local_auth.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class PasswordDetailPage extends StatefulWidget {
  final Passwords password;

  const PasswordDetailPage({Key key, this.password}) : super(key: key);

  @override
  _PasswordDetailPageState createState() => _PasswordDetailPageState(password);
}

class _PasswordDetailPageState extends State<PasswordDetailPage> {
  final Passwords password;

  _PasswordDetailPageState(this.password);

  TextEditingController masterPassController = TextEditingController();

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
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFA30003)),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
            padding: EdgeInsets.only(top: 40, right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFFA30003),
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Password Details",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (decrypt == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdatePasswordPage()),
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: Text(
                              'Please enter your master password first',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: "Subtitle"),
                            ),
                          );
                          scaffoldKey.currentState.showSnackBar(snackBar);
                        }
                      },
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.supervised_user_circle,
                                color: Color(0xFFA30003),
                                size: 40,
                              ),
                              title: Text("User Name"),
                              subtitle: Text(password.userName),
                            ),
                            ListTile(
                              leading: Icon(Icons.security,
                                  color: Color(0xFFA30003), size: 40),
                              title: Text("Password"),
                              subtitle:
                                  Text(decrypt ? decrypted : password.password),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text("** Enter your master pass to view your password", style: TextStyle(color: Color(0xFFA30003)),)
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    SizedBox(height: 20),
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
                controller: masterPassController,
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
                    password.password, masterPassController.text.trim());
                masterPassController.clear();
                if (decrypt) {
                  final snackBar = SnackBar(
                    content: Text(
                      'Verified',
                      style: TextStyle(fontFamily: "Subtitle"),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      'Wrong master password',
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
