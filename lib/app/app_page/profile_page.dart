import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File _profilePhoto;
  final picker = ImagePicker();

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

  void _takePhoto() async {
    var newPhoto = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _profilePhoto = File(newPhoto.path);
      Navigator.of(context).pop();
    });
  }

  void _photoArchive() async {
    var newPhoto = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _profilePhoto = File(newPhoto.path);
      Navigator.of(context).pop();
    });
  }

  void _updateProfilePhoto(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_profilePhoto != null) {
      var url = await _userModel.uploadFile(
          _userModel.appUser.userID, "profile_photo", _profilePhoto);

      if (url != null) {
        SensitivePlatformAlertDialog(
          title: "Successful",
          content: "Your profile photo has been updated",
          rightButtonText: "OK",
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName.text = _userModel.appUser.userName;
    print("Profil sayfasindaki user değerleri: " +
        _userModel.appUser.toString()); // test

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => _askForConfirmSignOut(context),),
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
                    Column(
                      children: <Widget>[
                        Text(
                          "User Profile",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height:20),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 200,
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text("Take Photo"),
                                          onTap: () {
                                            _takePhoto();
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.photo_album),
                                          title: Text("PhotoArchive"),
                                          onTap: () {
                                            _photoArchive();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: _profilePhoto == null
                                ? NetworkImage(
                                    _userModel.appUser.profilePhotoURL)
                                : FileImage(_profilePhoto),
                          ),
                        ),
                        SizedBox(height:20),
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
                        Text("You can change your user name", style: TextStyle(color: Colors.black54),),
                      ],
                    ),


                    AppButton(
                        buttonText: "Save",
                        textColor: Colors.white,
                        buttonColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          _updateUserName(context);
                          _updateProfilePhoto(context);
                        }),
                  ],
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                child: PageAvatar(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _doSignOut(BuildContext context) async {
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
      var updateResult = await _userModel.updateUserName(
          _userModel.appUser.userID, _controllerUserName.text);

      if (updateResult == true) {
        SensitivePlatformAlertDialog(
          title: "Successful",
          content: "Username has been changed",
          rightButtonText: "OK",
        ).show(context);
      } else {
        _controllerUserName.text = _userModel.appUser.userName;
        SensitivePlatformAlertDialog(
          title: "Error",
          content:
              "This username is already in use, please choose a different username",
          rightButtonText: "OK",
        ).show(context);
      }
    }
  }
}
