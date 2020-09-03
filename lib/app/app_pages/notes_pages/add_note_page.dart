
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/app/app_pages/assistant_page.dart';
import 'package:list_it_app/app/app_pages/notes_pages/notes_home_page.dart';
import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/page_title.dart';
import 'package:list_it_app/models/notes/notes.dart';
import 'package:list_it_app/models/notes/notes_category.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// ignore: must_be_immutable
class AddNotePage extends StatefulWidget {
  String title;
  Notes editNote;

  AddNotePage({this.title, this.editNote});

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var formKey = GlobalKey<FormState>();
  var formKeyForSearchDialog = GlobalKey<FormState>();
  List<NotesCategory> allCategories;
  List<Notes> allNotes;
  DatabaseHelper databaseHelper;
  NotesCategory selectedCategory;
  int categoryID;
  int selectedPriority;
  String noteTitle, noteContent;
  int selectedMenuItem = 1;
  static var _priority = ["low", "medium", "high"];

  //final Firestore _firestore = Firestore.instance;
  File _secilenResim;
  final picker = ImagePicker();
  FocusNode myFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCategories = List<NotesCategory>();
    allNotes = List<Notes>();
    myFocusNode = FocusNode();

    databaseHelper = DatabaseHelper();
    databaseHelper.getCategories().then((mapListContainingCategories) {
      for (Map readMap in mapListContainingCategories) {
        allCategories.add(NotesCategory.fromMap(readMap));
      }
      if (widget.editNote != null) {
        categoryID = widget.editNote.categoryID;
        selectedPriority = widget.editNote.notePriority;
      }

      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    super.dispose();
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
      body: Stack(children: <Widget>[
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
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: PageTitle(
                title: widget.title,
              ),
            ),
            SizedBox(height: 20),
            allCategories.length <= 0
                ? Center(
                    child: Column(children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Please add a category...",
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 20)),
                    ]),
                  )
                : Container(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20),
                        child: Column(children: <Widget>[
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Add category: ",
                                        style: TextStyle(
                                            color: Color(0xFFA30003))),

                                    //Kategori ekleme DropDownButton
                                    DropdownButton<NotesCategory>(
                                        style: TextStyle(color: Colors.black54),
                                        items: createCategoryItems(),
                                        hint: Text("Choose one"),
                                        elevation: 20,
                                        value: selectedCategory,
                                        onChanged: (NotesCategory
                                            userSelectedCategory) {
                                          setState(() {
                                            selectedCategory =
                                                userSelectedCategory;
                                            categoryID =
                                                userSelectedCategory.categoryID;
                                          });
                                        }),
                                  ]),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Priority: ",
                                  style: TextStyle(color: Color(0xFFA30003)),
                                ),

                                //Oncelik ekleme DropDownButton
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    hint: Text("Choose one"),
                                    elevation: 20,
                                    style: TextStyle(color: Colors.black54),
                                    items: _priority.map((priority) {
                                      return DropdownMenuItem<int>(
                                          child: Text(priority),
                                          value: _priority.indexOf(priority));
                                    }).toList(),
                                    value: selectedPriority,
                                    onChanged: (selectedPriorityID) {
                                      setState(() {
                                        selectedPriority = selectedPriorityID;
                                      });
                                    },
                                  ),
                                ),
                              ]),

                          //Not baslik
                          TextFormField(
                            /*style: TextStyle(
                                color: Theme.of(context).primaryColor),*/
                            initialValue: widget.editNote != null
                                ? widget.editNote.noteTitle
                                : "",
                            validator: (text) {
                              if (text.length <= 0) {
                                return "Please enter a title";
                              }
                              return null;
                            },
                            onSaved: (text) {
                              return noteTitle = text;
                            },
                            //focusNode: myFocusNode,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFA30003))),
                                labelText: "Title",
                                border: OutlineInputBorder()),
                          ),

                          SizedBox(height: 10),

                          TextFormField(
                            initialValue: widget.editNote != null
                                ? widget.editNote.noteContent
                                : "",
                            onSaved: (text) {
                              return noteContent = text;

                              //Image.file(_secilenResim);
                            },
                            //textInputAction: TextInputAction.continueAction,
                            focusNode: myFocusNode,
                            maxLines: 12,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFA30003))),
                              labelText: "Enter note content",
                              border: OutlineInputBorder(),
                            ),
                          ),

                          //Vazgec ve Kaydet butonları
                          ButtonBar(children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.black54,
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();

                                  var moment = DateTime.now();
                                  if (widget.editNote == null) {
                                    databaseHelper
                                        .addNote(Notes(
                                            categoryID,
                                            noteTitle,
                                            noteContent,
                                            moment.toString(),
                                            selectedPriority))
                                        .then((savedNoteID) {
                                      if (savedNoteID != 0) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NotesHomePage()));
                                      }
                                    });
                                  } else {
                                    databaseHelper
                                        .updateNote(Notes.withID(
                                            widget.editNote.noteID,
                                            categoryID,
                                            noteTitle,
                                            noteContent,
                                            moment.toString(),
                                            selectedPriority))
                                        .then((updatedNoteID) {
                                      if (updatedNoteID != 0) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NotesHomePage()));
                                      }
                                    });
                                  }
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xFFA30003),
                            ),
                          ]),
                        ]),
                      ),
                    ),
                  ),
          ]),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top:10,
          child: PageAvatar(

            avatarIcon: Icons.note_add,
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit, size: 30),
            title: Text("Write"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              size: 30,
            ),
            title: Text("Add photo"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mic,
              size: 30,
            ),
            title: Text("Record"),
          ),
        ],
        selectedItemColor: Color(0xFFA30003),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedMenuItem,
        onTap: (index) {
          setState(() {
            selectedMenuItem = index;
            switch (selectedMenuItem) {
              case 0:
                myFocusNode.requestFocus();

                break;

              case 1:
                showSearchDialogForNotes(context);

                break;

              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssistantPage()),
                );

                break;

              case 3:
                addPhoto(context);

                break;

              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addVoiceRecord()),
                );
            }
          });
        },
      ),
    );
  }

  List<DropdownMenuItem<NotesCategory>> createCategoryItems() {
    return allCategories.map((myCategory) {
      return DropdownMenuItem<NotesCategory>(
        value: myCategory,
        child: Text(myCategory.categoryTitle),
      );
    }).toList();
  }

  void showSearchDialogForNotes(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
            title: Text(
              "Search:",
              textAlign: TextAlign.start,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            children: <Widget>[
              Form(
                key: formKeyForSearchDialog,
                child: TextFormField(
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search for something",
                    border: OutlineInputBorder(),
                  ),
                  validator: (enteredValue) {
                    if (enteredValue.length <= 0) {
                      return "Enter a value for searching";
                    }
                    return null;
                  },
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
                    onPressed: () {},
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  addPhoto(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => new CupertinoAlertDialog(
              actions: <Widget>[
                FlatButton(
                    child: Text('Scan Document'),
                    onPressed: () {
                      //Navigator.of(context).pop();
                    }),
                FlatButton(
                    child: Text('Take a Photo or Video '),
                    onPressed: () {
                      //
                    }),
                FlatButton(
                    child: Text('Photo Archive'),
                    onPressed: () async {
                      myFocusNode.requestFocus();
                      Navigator.of(context).pop();
                      final pickedFile =
                          await picker.getImage(source: ImageSource.gallery);

                      setState(() {
                        _secilenResim = File(pickedFile.path);
                      });

                      StorageReference ref = FirebaseStorage.instance
                          .ref()
                          .child("user")
                          .child("emre")
                          .child("profil.png");
                      StorageUploadTask uploadTask = ref.putFile(_secilenResim);

                      var url = await (await uploadTask.onComplete)
                          .ref
                          .getDownloadURL();
                      debugPrint("upload edilen resmin url'si: " + url);
                    }),
                Card(
                  child: FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ));
  }

  addVoiceRecord() {}
}
