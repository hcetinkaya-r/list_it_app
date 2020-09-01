import 'package:cloud_firestore/cloud_firestore.dart';


class Note {
  String noteID;
  String categoryID;
  String categoryName;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  int priority;

  Note({this.noteID, this.categoryID, this.categoryName, this.title,
      this.content, this.createdAt, this.updatedAt, this.priority});

  Map<String, dynamic> toMap() {
    return {
      'noteID': noteID,
      'categoryID': categoryID,
      'categoryName': categoryName,
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
        categoryName = map['categoryName'],
        title = map['title'],
        content = map['content'],
        createdAt = (map['createdA'] as Timestamp).toDate(),
        updatedAt = (map["updatedAt"] as Timestamp).toDate(),
        priority = map['priority'];

  @override
  String toString() {
    return 'Note{noteID: $noteID, categoryID: $categoryID, categoryName: $categoryName, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, priority: $priority}';
  }
}
