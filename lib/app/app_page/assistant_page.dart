import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/common_widget/app_FAB.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/page_title.dart';

class AssistantPage extends StatelessWidget {
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
                  border: Border.all(color: Theme.of(context).primaryColor),
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
                              onPressed: () {},
                              toolTip: "Note",
                              heroTag: "Note",
                              fabIcon: Icons.note_add,
                              width: 65,
                              height: 65,
                            ),
                            SizedBox(height: 10),
                            Text("Notes", style: TextStyle(color: Colors.black54, fontSize: 16),),
                          ],
                        ),
                        Column(
                          children: [
                            AppFAB(
                              onPressed: () {},
                              toolTip: "Budget",
                              heroTag: "Budget",
                              fabIcon: Icons.pie_chart_outlined,
                              width: 65,
                              height: 65,
                            ),
                            SizedBox(height: 10),
                            Text("Budget", style: TextStyle(color: Colors.black54, fontSize: 16),),
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
                              onPressed: () {},
                              toolTip: "Password",
                              heroTag: "Password",
                              fabIcon: Icons.security,
                              width: 65,
                              height: 65,
                            ),
                            SizedBox(height: 10),
                            Text("Security", style: TextStyle(color: Colors.black54, fontSize: 16),),
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
                            ),
                            SizedBox(height: 10),
                            Text("Reminders", style: TextStyle(color: Colors.black54, fontSize: 16),),
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
