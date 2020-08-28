import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AppUser {
  final String userID;
  String email;
  String userName;
  String profilePhotoURL;
  DateTime createdAt;
  DateTime updatedAt;
  int level;

  AppUser({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      'email': email,
      'userName': userName ?? '',
      'profilePhotoURL': profilePhotoURL ??
          'https://party.coop/wp-content/blogs.dir/5/files/2020/02/Love-It-Bright-560x342.png',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'level': level ?? 1,
    };
  }

  AppUser.fromMap(Map<String, dynamic> map)
      :
        userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilePhotoURL = map['profilePhotoURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        level = map['level'];

  @override
  String toString() {
    return 'AppUser{userID: $userID, email: $email, userName: $userName, profilePhotoURL: $profilePhotoURL, createdAt: $createdAt, updatedAt: $updatedAt, level: $level}';
  }
}
