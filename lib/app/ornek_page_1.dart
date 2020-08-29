import 'package:flutter/material.dart';
import 'package:list_it_app/app/ornek_page_2.dart';

class OrnekPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ornek page 1"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.title),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => OrnekPage2()));
              }),
        ],
      ),

      body: Center(
        child: Container(
          child: Text("Ornek page 1 Sayfasi"),
        ),
      ),
    );
  }
}
