import 'package:flutter/material.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[

          FlatButton(
          onPressed: () => _doSignOut(context),
            child: Text("SignOut", style: TextStyle(color: Colors.white),),


        ),],
      ),
      body: Center(
        child: Text("Profile Page"),
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
