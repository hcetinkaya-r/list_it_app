import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Note {
  final String noteID;
  final String categoryID;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  int priority;

  Note(
      {@required this.noteID, @required this.categoryID, @required this.title});

  Map<String, dynamic> toMap() {
    return {
      'noteID': noteID,
      'categoryID': categoryID,
      'title': title,
      'content': content,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'priority': priority ?? 1,
    };
  }

  Note.fromMap(Map<String, dynamic> map)
      : noteID = map['noteID'],
        categoryID = map['categoryID'],
        title = map['title'],
        content = map['content'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        priority = map['priority'];

  @override
  String toString() {
    return 'Note{noteID: $noteID, categoryID: $categoryID, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, priority: $priority}';
  }
}
