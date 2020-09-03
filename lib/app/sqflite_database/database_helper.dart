import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:list_it_app/models/notes/notes.dart';
import 'package:list_it_app/models/notes/notes_category.dart';
import 'package:list_it_app/models/passwords/password.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "list_it.db");

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "list_it.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    return await openDatabase(path, readOnly: false);
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    var db = await _getDatabase();
    var result = db.query("Categories");
    return result;
  }

  Future<List<NotesCategory>> getCategoryList() async {
    var mapListWithCategories = await getCategories();
    var categoryList = List<NotesCategory>();
    for (Map map in mapListWithCategories) {
      categoryList.add(NotesCategory.fromMap(map));
    }
    return categoryList;
  }

  Future<int> addCategory(NotesCategory category) async {
    var db = await _getDatabase();
    var result = db.insert("Categories", category.toMap());
    return result;
  }

  Future<int> updateCategory(NotesCategory category) async {
    var db = await _getDatabase();
    var result = db.update("Categories", category.toMap(),
        where: 'categoryID = ?', whereArgs: [category.categoryID]);
    return result;
  }

  Future<int> deleteCategory(int categoryID) async {
    var db = await _getDatabase();
    var result = db
        .delete("Categories", where: 'categoryID = ?', whereArgs: [categoryID]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    var db = await _getDatabase();
    var result = db.rawQuery(
        "select * from Notes inner join Categories on Categories.categoryID = Notes.categoryID order by noteID Desc ");
    return result;
  }

  Future<List<Notes>> getNoteList() async {
    var mapListWithNotes = await getNotes();
    var noteList = List<Notes>();
    for (Map map in mapListWithNotes) {
      noteList.add(Notes.fromMap(map));
    }
    return noteList;
  }

  Future<int> addNote(Notes note) async {
    var db = await _getDatabase();
    var result = db.insert("Notes", note.toMap());
    return result;
  }

  Future<int> updateNote(Notes note) async {
    var db = await _getDatabase();
    var result = db.update("Notes", note.toMap(),
        where: 'noteID = ?', whereArgs: [note.noteID]);
    return result;
  }

  Future<int> deleteNote(noteID) async {
    var db = await _getDatabase();
    var result = db.delete("Notes", where: 'noteID = ?', whereArgs: [noteID]);
    return result;
  }

  /*Future<List<Map<String, dynamic>>> getReminders() async {
    var db = await _getDatabase();
    var result = db.query("Reminders order by reminderID Desc");
    return result;
  }

  Future<List<Reminders>> getReminderList() async {
    var mapListWithReminders = await getReminders();
    var reminderList = List<Reminders>();
    for (Map map in mapListWithReminders) {
      reminderList.add(Reminders.fromMap(map));
    }
    return reminderList;
  }

  Future<int> addReminder(Reminders reminder) async {
    var db = await _getDatabase();
    var result = db.insert("Reminders", reminder.toMap());
    return result;
  }

  Future<int> updateReminder(Reminders reminder) async {
    var db = await _getDatabase();
    var result = db.update("Reminders", reminder.toMap(),
        where: 'reminderID = ?', whereArgs: [reminder.reminderID]);
    return result;
  }

  Future<int> deleteReminder(reminderID) async {
    var db = await _getDatabase();
    var result = db.delete("Reminders", where: 'reminderID = ?', whereArgs: [reminderID]);
    return result;
  }*/

  Future<List<Map<String, dynamic>>> getPasswords() async {
    var db = await _getDatabase();
    var result = db.query("Passwords order by passwordID Desc");
    return result;
  }

  Future<List<Passwords>> getPasswordList() async {
    var mapListWithPasswords = await getPasswords();
    var passwordList = List<Passwords>();
    for (Map map in mapListWithPasswords) {
      passwordList.add(Passwords.fromMap(map));
    }
    return passwordList;
  }

  Future<int> addPassword(Passwords password) async {
    var db = await _getDatabase();
    var result = db.insert("Passwords", password.toMap());
    return result;
  }

  Future<int> updatePassword(Passwords password) async {
    var db = await _getDatabase();
    var result = db.update("Passwords", password.toMap(),
        where: 'passwordID = ?', whereArgs: [password.passwordID]);
    return result;
  }

  Future<int> deletePassword(passwordID) async {
    var db = await _getDatabase();
    var result = db
        .delete("Passwords", where: 'passwordID = ?', whereArgs: [passwordID]);
    return result;
  }

  deleteAllPasswords() async {
    final db = await _getDatabase();
    var result = db.delete("Passwords");
    return result;
  }

  //quotation from Stackoverflow(Raoul Scalise)

  String dateFormat(DateTime tm) {
    DateTime today = new DateTime.now();
    Duration oneDay = new Duration(days: 1);
    Duration twoDay = new Duration(days: 2);
    Duration oneWeek = new Duration(days: 7);
    String month;
    switch (tm.month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }

    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "Today";
    } else if (difference.compareTo(twoDay) < 1) {
      return "Yesterday";
    } else if (difference.compareTo(oneWeek) < 1) {
      switch (tm.weekday) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
    } else if (tm.year == today.year) {
      return '${tm.day} $month';
    } else {
      return '${tm.day} $month ${tm.year}';
    }
    return "";
  }

/*Future<List<Map<String, dynamic>>> getTags() async {
    var db = await _getDatabase();
    var result = db.query("Tags", orderBy: 'tagID DESC');
    return result;
  }

  Future<List<Tags>> getTagList() async {
    var mapListWithTag = await getTags();
    var tagList = List<Tags>();
    for (Map map in mapListWithTag) {
      tagList.add(Tags.fromMap(map));
    }
    return tagList;
  }

  Future<int> addTag(Tags tag) async {
    var db = await _getDatabase();
    var result = db.insert("Tags", tag.toMap());
    return result;
  }

  Future<int> deleteTag(int tagID) async {
    var db = await _getDatabase();
    var result = db.delete("Tags", where: 'tagID = ?', whereArgs: [tagID]);
    return result;
  }*/

}
