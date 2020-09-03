import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:list_it_app/app/app_page/passwords_pages/passwords_home_page.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/page_title.dart';
import 'package:local_auth/local_auth.dart';

// ignore: must_be_immutable
class SetMasterPasswordPage extends StatefulWidget {
  String title;


  SetMasterPasswordPage({this.title});

  @override
  _SetMasterPasswordPageState createState() => _SetMasterPasswordPageState();
}

class _SetMasterPasswordPageState extends State<SetMasterPasswordPage> {
  TextEditingController masterPassController = TextEditingController();

  Future<Null> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'masterPass') ?? '';
    masterPassController.text = masterPass;
  }

  saveMasterPass(String masterPass) async {
    final storage = new FlutterSecureStorage();

    await storage.write(key: 'masterPass', value: masterPass);
  }

  authenticate() async {
    var localAuth = LocalAuthentication();
    bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to change master password',
        stickyAuth: true);

    if (!didAuthenticate) {
      Navigator.pop(context);
    }
    masterPassController.text = "";

    print(didAuthenticate);
  }

  @override
  void initState() {
    super.initState();
    authenticate();
    getMasterPass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xFFA30003)),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
            padding: EdgeInsets.only(right: 30, left: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFFA30003),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                PageTitle(
                  title: widget.title,
                  textSize: 27,
                ),
                TextField(
                  obscureText: true,
                  maxLength: 32,
                  decoration: InputDecoration(
                      labelText: "Master Pass",
                      labelStyle: TextStyle(fontFamily: "Subtitle"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  controller: masterPassController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: AppButton(
                      buttonText: "Set Master Password",
                      textColor: Colors.white,
                      buttonColor: Color(0xFFA30003),
                      onPressed: () async {
                        if (masterPassController.text.isNotEmpty) {
                          saveMasterPass(masterPassController.text.trim());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PasswordsHomePage()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Error!",
                                    style: TextStyle(fontFamily: "Title"),
                                  ),
                                  content: Text(
                                    "Please enter valid Master Password.",
                                    style: TextStyle(fontFamily: "Subtitle"),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "CLOSE",
                                        style:
                                            TextStyle(color: Color(0xFFA30003)),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      }),
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
}
