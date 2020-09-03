import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/app/app_page/assistant_page.dart';
import 'package:list_it_app/app/app_page/passwords_pages/add_password_page.dart';
import 'package:list_it_app/app/app_page/passwords_pages/password_detail_page.dart';
import 'package:list_it_app/app/app_page/passwords_pages/set_master_password_page.dart';
import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/models/passwords/password.dart';
import 'package:list_it_app/models/passwords/passwords_bloc.dart';

class PasswordsHomePage extends StatefulWidget {
  @override
  _PasswordsHomePageState createState() => _PasswordsHomePageState();
}

class _PasswordsHomePageState extends State<PasswordsHomePage> {
  final bloc = PasswordsBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xFFA30003),
        ),

        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssistantPage()));
            },
            child: Icon(Icons.arrow_back_ios)),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "Change Master Password",
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Color(0xFFA30003),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SetMasterPasswordPage(title: "Update Master Password")));}
            ),
          ],
        ),
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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "Passwords",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30,
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Passwords>>(
                    stream: bloc.passwords,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              Passwords password = snapshot.data[index];
                              return Card(
                                child: Dismissible(
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Color(0xFFA30003),
                                  ),
                                  key: ObjectKey(password.passwordID),
                                  onDismissed: (direction) {
                                    var item = password;
                                    DatabaseHelper.db
                                        .deletePassword(item.passwordID);
                                    setState(() {
                                      snapshot.data.removeAt(index);
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("Password deleted"),
                                        action: SnackBarAction(
                                            label: "Deleted",
                                            onPressed: () {
                                              DatabaseHelper.db
                                                  .addPassword(item);
                                              setState(() {
                                                snapshot.data
                                                    .insert(index, item);
                                              });
                                            })));
                                  },
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PasswordDetailPage(
                                                    password: password,
                                                  )));
                                    },
                                    child: ListTile(
                                      trailing: Icon(Icons.arrow_back_ios,
                                          color: Color(0xFFA30003)),
                                      title: Text(
                                        password.registrationName,
                                      ),
                                      leading: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.security,
                                            color: Color(0xFFA30003),
                                          )),
                                      subtitle: password.userName != ""
                                          ? Text(
                                              password.userName,
                                              style: TextStyle(
                                                fontFamily: 'Subtitle',
                                              ),
                                            )
                                          : Text(
                                              "No username specified",
                                              style: TextStyle(
                                                fontFamily: 'Subtitle',
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              "No Passwords Saved. \nClick \"+\" button to add a password",
                              textAlign: TextAlign.center,
                              // style: TextStyle(color: Colors.black54),
                            ),
                            // ignore: missing_return
                          );
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add_circle_outline,
                      color: Colors.black54, size: 40),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AddPasswordPage()));
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Add new password",
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 20),
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
