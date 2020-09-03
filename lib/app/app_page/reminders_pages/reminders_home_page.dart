import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:list_it_app/app/app_page/reminders_pages/add_reminder_page.dart';
import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/common_widget/app_FAB.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/models/reminders/reminders.dart';

class RemindersHomePage extends StatefulWidget {
  @override
  _RemindersHomePageState createState() => _RemindersHomePageState();
}

class _RemindersHomePageState extends State<RemindersHomePage> {
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DatabaseHelper databaseHelper;
  List<Reminders> allReminders;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Reminders selectedReminder;
  String selectedReminderTitle,
      selectedReminderContent,
      selectedReminderTime,
      selectedReminderDate;

  initializeNotifications() async {
    var initializeAndroid = AndroidInitializationSettings('ic_launcher');
    var initializeIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(initializeAndroid, initializeIOS);
    await localNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Text("Notification"), content: Text("$payload")));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allReminders = List<Reminders>();
    databaseHelper = DatabaseHelper();
    initializeNotifications();
    //selectedReminder= Reminders(selectedReminderTitle, selectedReminderContent, selectedReminderTime, selectedReminderDate);

    setState(() {});
  }

  Future singleNotification(
      DateTime dateTime, String message, String subText, int hashCode,
      {String sound}) async {
    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      'channel-decription',
      importance: Importance.Max,
      priority: Priority.Max,
    );

    var iosChannel = IOSNotificationDetails();

    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    localNotificationsPlugin.schedule(
        hashCode, message, subText, dateTime, platformChannel,
        payload: hashCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xFFA30003)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  border: Border.all(color: Color(0xFFA30003)),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder<List<Reminders>>(
                          future: databaseHelper.getReminderList(),
                          builder: (context,
                              AsyncSnapshot<List<Reminders>> snapShot) {
                            if (snapShot.hasData) {
                              allReminders = snapShot.data;

                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: allReminders.length,
                                itemBuilder: (contex, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 10),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return SimpleDialog(
                                                title: Text(
                                                  "Are you sure to delete reminder?",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                children: <Widget>[
                                                  ButtonBar(
                                                    children: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.teal),
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          _deleteReminder(
                                                              allReminders[
                                                                      index]
                                                                  .reminderID);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Delete ",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFA30003)),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.black54, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    allReminders[index]
                                                        .reminderTitle,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFA30003)),
                                                  ),
                                                  Text(allReminders[index]
                                                      .reminderContent),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    allReminders[index]
                                                        .reminderDate,
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  Text(
                                                    allReminders[index]
                                                        .reminderTime,
                                                    style: TextStyle(
                                                        color: Colors.teal),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(child: Text("Add reminder..."));
                            }
                          }),
                    ),
                    AppFAB(
                        onPressed: () async {
                          DateTime now = DateTime.now().add(
                            Duration(seconds: 5),
                          );
                          await singleNotification(now, "Notification",
                              "This is Notification", 123456);
                        },
                        fabIcon: Icons.notifications,
                        toolTip: "Add Notification",
                        heroTag: "Notification"),
                    SizedBox(height: 10),
                    AppFAB(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddReminderPage(),
                          ),
                        );
                      },
                      fabIcon: Icons.add_circle_outline,
                      toolTip: "Add reminder",
                      heroTag: "Reminder",
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add Reminder",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                child: PageAvatar(
                  avatarIcon: Icons.timer,
                  iconSize: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteReminder(int reminderID) {
    databaseHelper.deleteReminder(reminderID).then((deletedReminderID) {
      if (deletedReminderID != 0) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text("Reminder deleted!")));
        setState(() {});
      }
    });
  }
}
