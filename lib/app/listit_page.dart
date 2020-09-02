import 'package:flutter/material.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';

class ListItPage extends StatefulWidget {
  @override
  _ListItPageState createState() => _ListItPageState();
}

class _ListItPageState extends State<ListItPage> {
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
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "List-it",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
      Positioned(
        width: MediaQuery.of(context).size.width,
        top:10,
        child: PageAvatar(
          avatarIcon: Icons.list,
        ),
      ),
        ],
      ),
    );
  }
}
