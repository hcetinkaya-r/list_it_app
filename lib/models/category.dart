import 'package:flutter/cupertino.dart';

class Category {
  final String categoryID;
  String categoryName;

  Category({@required this.categoryID, @required this.categoryName});

  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'categoryName': categoryName,
    };
  }

  Category.fromMap(Map<String, dynamic> map)
      : categoryID = map['categoryID'],
        categoryName = map['categoryName'];

  @override
  String toString() {
    return 'Category{categoryID: $categoryID, categoryName: $categoryName}';
  }
}
