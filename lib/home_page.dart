import 'package:flutter/material.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
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
        title: Text("Ana Sayfa"),
        actions: <Widget>[
          FlatButton(
              onPressed: () => _cikisYap(context), child: Text("Çıkış yap"))
        ],
      ),
      body: Center(
        child: Text("Hoşgeldiniz ${appUser.userID}"),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    Provider.of<UserModel>(context, listen: false);

    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.signOut();

    return sonuc;
  }
}
