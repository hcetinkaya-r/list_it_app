import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:list_it_app/app/app_page/budget_pages/budget_home_page.dart';
import 'package:list_it_app/app/app_page/passwords_pages/passwords_home_page.dart';
import 'package:list_it_app/app/app_page/passwords_pages/set_master_password_page.dart';
import 'package:list_it_app/common_widget/app_FAB.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/page_title.dart';
import 'package:list_it_app/app/app_page/notes/notes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssistantPage extends StatefulWidget {
  @override
  _AssistantPageState createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  int launch = 0;


  Future checkPasswordsFirstPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    launch = prefs.getInt("launch") ?? 0;

    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';


      if (launch == 0 && masterPass == '') {
        await prefs.setInt('launch', launch++);
      }



  }


  @override
  void initState() {
    checkPasswordsFirstPage();
    super.initState();
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
                  border: Border.all(color: Color(0xFFA30003)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PageTitle(title: "Your Assistant"),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: [
                            AppFAB(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotesPage(),
                                  ),
                                );
                              },
                              toolTip: "Note",
                              heroTag: "Note",
                              fabIcon: Icons.note_add,
                              width: 65,
                              height: 65,
                              borderColor: Color(0xFFA30003),
                              iconColor: Color(0xFFA30003),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Notes",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            AppFAB(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BudgetHomePage(),
                                  ),
                                );
                              },
                              toolTip: "Budget",
                              heroTag: "Budget",
                              fabIcon: Icons.pie_chart_outlined,
                              width: 65,
                              height: 65,
                              borderColor: Color(0xFFA30003),
                              iconColor: Color(0xFFA30003),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Budget",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: [
                            AppFAB(
                              onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordsHomePage()));
                                },

                              toolTip: "Password",
                              heroTag: "Password",
                              fabIcon: Icons.security,
                              width: 65,
                              height: 65,
                              borderColor: Color(0xFFA30003),
                              iconColor: Color(0xFFA30003),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Passwords",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            AppFAB(
                              onPressed: () {},
                              toolTip: "Reminder",
                              heroTag: "Reminder",
                              fabIcon: Icons.timer,
                              width: 65,
                              height: 65,
                              borderColor: Color(0xFFA30003),
                              iconColor: Color(0xFFA30003),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Reminders",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                child: PageAvatar(
                  avatarIcon: Icons.assistant,
                  iconSize: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
