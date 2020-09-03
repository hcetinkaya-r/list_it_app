import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_it_app/app/app_page/reminders_pages/reminders_home_page.dart';
import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/page_title.dart';
import 'package:list_it_app/models/reminders/reminders.dart';

class AddReminderPage extends StatefulWidget {
  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller;
  String reminderTitle, reminderContent, reminderDate, reminderTime;
  List<Reminders> allReminders;
  DatabaseHelper databaseHelper;
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  DateTime firstDate = DateTime(DateTime.now().year - 5);
  DateTime lastDate = DateTime(DateTime.now().year + 5);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    reminderTitle = controller.text.toString();

    databaseHelper = DatabaseHelper();
    allReminders = List<Reminders>();
    currentDate = DateTime.now();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
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
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Color(0xFFA30003)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PageTitle(
                      title: "Add Reminder",
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton.icon(
                                textColor: Colors.white,
                                color: Colors.teal,
                                onPressed: () {
                                  showDatePicker(
                                          initialEntryMode:
                                              DatePickerEntryMode.input,
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          context: context,
                                          initialDate: currentDate,
                                          firstDate: firstDate,
                                          lastDate: lastDate)
                                      .then((selectedDate) {
                                    if (selectedDate != null) {
                                      reminderDate = formatDate(selectedDate,
                                          [yyyy, '-', mm, '-', dd]);
                                    } else {
                                      return null;
                                    }
                                  });
                                },
                                icon: Icon(Icons.date_range),
                                label: Container(child: Text("Select Date")),
                              ),
                              FlatButton.icon(
                                textColor: Colors.white,
                                color: Colors.blueGrey,
                                onPressed: () {
                                  showTimePicker(
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                          context: context,
                                          initialTime: currentTime)
                                      .then((selectedTime) {
                                    if (selectedTime != null) {
                                      reminderTime =
                                          selectedTime.format(context);
                                    } else {
                                      return null;
                                    }
                                  });
                                },
                                icon: Icon(Icons.access_time),
                                label: Container(
                                  child: Text("Select Time"),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: "Reminders title",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              prefixIcon: Icon(Icons.title),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            validator: (text) {
                              if (text.length <= 0) {
                                return "Please enter a reminder title";
                              }
                              return null;
                            },
                            onSaved: (text) {
                              return reminderTitle = text;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            maxLines: 15,
                            decoration: InputDecoration(
                              hintText: "Content",
                              labelText: "Enter reminder content",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              prefixIcon: Icon(Icons.content_paste),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onSaved: (text) {
                              return reminderContent = text;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 300,
                            child: RaisedButton(
                                child: Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Color(0xFFA30003),
                                onPressed: () {
                                  _saveReminder();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RemindersHomePage()));
                                }),
                          ),
                        ],
                      ),
                    )
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

  void _saveReminder() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      databaseHelper
          .addReminder(Reminders(
        reminderTitle,
        reminderContent,
        reminderDate,
        reminderTime,
      ))
          .then((savedReminderID) {
        if (savedReminderID != 0) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RemindersHomePage()));
        }
      });
    }
  }
}
