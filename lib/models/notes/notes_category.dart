class NotesCategory {
  int categoryID;
  String categoryTitle;

  NotesCategory(this.categoryTitle);

  NotesCategory.withID(this.categoryID, this.categoryTitle);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['categoryID'] = categoryID;
    map['categoryTitle'] = categoryTitle;
    return map;
  }

  NotesCategory.fromMap(Map<String, dynamic> map) {
    this.categoryID = map['categoryID'];
    this.categoryTitle = map['categoryTitle'];
  }

  @override
  String toString() {
    return 'Categories{categoryID: $categoryID, categoryTitle: $categoryTitle}';
  }
}
