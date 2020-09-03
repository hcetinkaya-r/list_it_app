import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/app/app_pages/notes_pages/category_list_dialog.dart';
import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/common_widget/app_FAB.dart';
import 'package:list_it_app/common_widget/flat_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/page_title.dart';
import 'package:list_it_app/models/notes/notes.dart';
import 'package:list_it_app/models/notes/notes_category.dart';
import 'add_note_page.dart';

class NotesHomePage extends StatefulWidget {
  @override
  _NotesHomePageState createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  DatabaseHelper databaseHelper;
  List<Notes> allNotes;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allNotes = List<Notes>();
    databaseHelper = DatabaseHelper();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFA30003),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CategoryListDialog(),
                    );
                  });
            }),
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
            child: Padding(
              padding:
                  EdgeInsets.only(right: 10, left: 10, top: 50, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PageTitle(
                    title: "Notes",
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: FutureBuilder<List<Notes>>(
                        future: databaseHelper.getNoteList(),
                        builder:
                            (context, AsyncSnapshot<List<Notes>> snapShot) {
                          if (snapShot.hasData) {
                            allNotes = snapShot.data;

                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: allNotes.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ExpansionTile(
                                      leading: _assignPriorityIcon(
                                          allNotes[index].notePriority),
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      title: Text(
                                        allNotes[index].noteTitle,
                                        style:
                                            TextStyle(color: Color(0xFFA30003)),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            allNotes[index].categoryTitle,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Text(databaseHelper.dateFormat(
                                              DateTime.parse(
                                                  allNotes[index].noteDate))),
                                        ],
                                      ),
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            allNotes[index].noteContent,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        ButtonBar(
                                          alignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            AppFlatButton(
                                                buttonText: "Update",
                                                buttonTextColor: Colors.green,
                                                onPressed: () {
                                                  _goAddNoteScreenForUpdate(
                                                      context, allNotes[index]);
                                                }),
                                            AppFlatButton(
                                              buttonText: "Delete",
                                              buttonTextColor: Theme.of(context)
                                                  .primaryColor,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) {
                                                      return SimpleDialog(
                                                        title: Text(
                                                          "Are you sure to delete reminder?",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        children: <Widget>[
                                                          ButtonBar(
                                                            children: <Widget>[
                                                              AppFlatButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                               buttonText: "Cancel",

                                                              ),
                                                              AppFlatButton(
                                                                onPressed: () {
                                                                  _deleteNote(allNotes[
                                                                          index]
                                                                      .noteID);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                buttonText: "Delete",
                                                                buttonTextColor: Theme.of(context).primaryColor,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return Center(child: Text("Loading..."));
                          }
                        }),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          AppFAB(
                              toolTip: "Add Category",
                              heroTag: "Category",
                              fabIcon: Icons.add_circle_outline_sharp,
                              iconColor: Color(0xFFA30003),
                              mini: true,
                              onPressed: () {
                                addCategoryDialog(context);
                              }),
                          SizedBox(height: 10),
                          Text(
                            "Add Category",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          AppFAB(
                            toolTip: "Add Note",
                            heroTag: "Note",
                            fabIcon: Icons.add_circle_outline,
                            borderColor: Colors.black54,
                            onPressed: () async {
                              var result = await _goAddNoteScreen(context);
                              if (result != null) {
                                setState(() {});
                              }
                            },
                          ),


                          SizedBox(height: 10),
                          Text(
                            "Add Note",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: 10,
              child: PageAvatar(
                avatarIcon: Icons.note_add,
              )),
        ],
      ),
    );
  }

  void addCategoryDialog(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String newCategoryName;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Add category:",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          children: <Widget>[
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (newValue) {
                    newCategoryName = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: "Category name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (enteredCategoryName) {
                    if (enteredCategoryName.length <= 0) {
                      return "Please enter a category name";
                    }
                    return null;
                  },
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black54,
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      databaseHelper
                          .addCategory(NotesCategory(newCategoryName))
                          .then((categoryID) {
                        if (categoryID > 0) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Category added"),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  color: Color(0xFFA30003),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _goAddNoteScreen(BuildContext context) async {
    final result = await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => AddNotePage(title: "New Note")));

    return result;
  }

  _assignPriorityIcon(int notePriority) {
    switch (notePriority) {
      case 0:
        return CircleAvatar(
          radius: 24,
          child: Text(
            "low",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black12,
        );
        break;
      case 1:
        return CircleAvatar(
          radius: 24,
          child: Text(
            "medium",
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
          backgroundColor: Colors.black26,
        );
        break;
      case 2:
        return CircleAvatar(
          radius: 24,
          child: Text(
            "high",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black54,
        );
        break;
    }
  }

  _goAddNoteScreenForUpdate(BuildContext context, Notes note) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => AddNotePage(
              title: "Update Note",
              editNote: note,
            )));
  }

  _deleteNote(int noteID) {
    databaseHelper.deleteNote(noteID).then((deletedID) {
      if (deletedID != 0) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("Note deleted!")));
        setState(() {});
      }
    });
  }
}
