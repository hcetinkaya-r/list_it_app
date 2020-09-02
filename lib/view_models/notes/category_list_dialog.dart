
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/models/notes/notes_category.dart';

class CategoryListDialog extends StatefulWidget {
  @override
  _CategoryListDialogState createState() => _CategoryListDialogState();
}

class _CategoryListDialogState extends State<CategoryListDialog> {
  List<NotesCategory> allCategories;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (allCategories == null) {
      allCategories = List<NotesCategory>();
      updateCategoryList();
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xFFA30003)),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              "Categories:",
              style: TextStyle(
                color: Color(0xFFA30003),
                fontSize: 30,
              ),
            ),
            Column(
              children: <Widget>[
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: allCategories.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () =>
                              _updateCategory(allCategories[index], context),
                          title: Text(allCategories[index].categoryTitle),
                          subtitle: Text(
                            "Tap to update",
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                          trailing: InkWell(
                            child: Icon(
                              Icons.delete,
                              color: Color(0xFFA30003),
                            ),
                            onTap: () => _deleteCategory(
                                allCategories[index].categoryID),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateCategoryList() {
    databaseHelper.getCategoryList().then((listWithCategories) {
      setState(() {
        allCategories = listWithCategories;
      });
    });
  }

  _deleteCategory(int categoryID) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              title: Text(
                "Delete category",
                style: TextStyle(
                  color: Color(0xFFA30003),
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Are you sure?"),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.black54,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        color: Color(0xFFA30003),
                        onPressed: () {
                          databaseHelper
                              .deleteCategory(categoryID)
                              .then((deletedCategory) {
                            if (deletedCategory != 0) {
                              setState(() {
                                updateCategoryList();
                                Navigator.pop(context);
                              });
                            }
                          });
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  _updateCategory(NotesCategory categoryToBeUpdated, BuildContext ctx) {
    updateCategoryDialog(ctx, categoryToBeUpdated);
  }

  void updateCategoryDialog(
      BuildContext myContext, NotesCategory categoryToBeUpdated) {
    var formKey = GlobalKey<FormState>();
    String categoryNameToUpdate;
    showDialog(
      barrierDismissible: false,
      context: myContext,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Update category:",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          children: <Widget>[
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: categoryToBeUpdated.categoryTitle,
                  onSaved: (newValue) {
                    categoryNameToUpdate = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: "Category name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (enteredCategoryName) {
                    if (enteredCategoryName.length <= 0) {
                      return "Please enter Category name";
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
                          .updateCategory(NotesCategory.withID(
                              categoryToBeUpdated.categoryID,
                              categoryNameToUpdate))
                          .then((categoryID) {
                        if (categoryID != 0) {
                          Scaffold.of(myContext).showSnackBar(SnackBar(
                            content: Text("Category updated"),
                            duration: Duration(seconds: 1),
                          ));
                          updateCategoryList();
                          Navigator.of(context).pop();
                        }
                      });

                      /* databaseHelper
                        .addCategory(Categories(newCategoryName))
                        .then((categoryID) {
                      if (categoryID > 0) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Category added"),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    });
                    Navigator.pop(context);*/
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
}
