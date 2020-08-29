import 'package:flutter/material.dart';
import 'package:list_it_app/app/ornek_page_1.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.title),
              onPressed: () {
                Navigator.of(context,rootNavigator: true).push(
                    MaterialPageRoute(fullscreenDialog: true, builder: (context) => OrnekPage1()));
              }),
        ],


      ),
      body: Center(
        child: Text("Users Page"),
      ),
    );
  }
}
