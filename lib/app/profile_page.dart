import 'package:flutter/material.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/sensitive_platform_alert_dialog.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _controllerUserName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName.text = _userModel.appUser.userName;
    print("Profil sayfasindaki user değerleri: " +
        _userModel.appUser.toString()); // test

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Profile"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _askForConfirmSignOut(context),
            child: Text(
              "SignOut",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "User Profile",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black54,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage(_userModel.appUser.profilePhotoURL),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: _userModel.appUser.email,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Your E-Mail",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _controllerUserName,
                        decoration: InputDecoration(
                          labelText: "Your User Name",
                          prefixIcon: Icon(Icons.drive_file_rename_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    AppButton(
                        buttonText: "Save",
                        onPressed: () {
                          _updateUserName(context);
                        }),
                  ],
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                child: PageAvatar(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> _doSignOut(BuildContext context) async {
    Provider.of<UserModel>(context, listen: false);

    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool result = await _userModel.signOut();

    return result;
  }

  Future _askForConfirmSignOut(BuildContext context) async {
    final result = await SensitivePlatformAlertDialog(
      title: "Are you sure?",
      content: "Are you sure to sign out?",
      rightButtonText: "Yes",
      leftButtonText: "No",
    ).show(context);

    if (result) {
      _doSignOut(context);
    }
  }

  void _updateUserName(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_userModel.appUser.userName != _controllerUserName.text) {
     var updateResult =  await _userModel.updateUserName(_userModel.appUser.userID, _controllerUserName.text);

     if(updateResult == true){
       SensitivePlatformAlertDialog(
         title: "Successful",
         rightButtonText: "Username has been changed",
       ).show(context);
     }else{
       SensitivePlatformAlertDialog(
         title: "Error",
         rightButtonText: "This username is already in use, please choose a different username",
       ).show(context);

     }

    } else {
      SensitivePlatformAlertDialog(
        title: "Error",
        rightButtonText: "You did not change your username",
      ).show(context);
    }


  }
}
