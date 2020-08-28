import 'package:flutter/material.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  final AppUser appUser;


  HomePage({
    Key key,
    @required this.appUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        title: Text("Main Page"),
        actions: <Widget>[
          FlatButton(
              onPressed: () => _doSignOut(context), child: Text("Sign out"))
        ],
      ),
      body: Center(
        child: Text("Welcome... ${appUser.userID}"),
      ),
    );
  }

  Future<bool> _doSignOut(BuildContext context) async {
    Provider.of<UserModel>(context, listen: false);

    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool result = await _userModel.signOut();

    return result;
  }
}
