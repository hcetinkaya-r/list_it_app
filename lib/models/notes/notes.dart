class Notes {
  int noteID;
  int categoryID;
  String categoryTitle;
  String noteTitle;
  String noteContent;
  String noteDate;
  int notePriority;

  Notes(this.categoryID, this.noteTitle, this.noteContent, this.noteDate,
      this.notePriority);

  Notes.withID(this.noteID, this.categoryID, this.noteTitle, this.noteContent,
      this.noteDate, this.notePriority);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['noteID'] = noteID;
    map['categoryID'] = categoryID;
    map['noteTitle'] = noteTitle;
    map['noteContent'] = noteContent;
    map['noteDate'] = noteDate;
    map['notePriority'] = notePriority;

    return map;
  }

  Notes.fromMap(Map<String, dynamic> map) {
    this.noteID = map['noteID'];
    this.categoryID = map['categoryID'];
    this.categoryTitle = map['categoryTitle'];
    this.noteTitle = map['noteTitle'];
    this.noteContent = map['noteContent'];
    this.noteDate = map['noteDate'];
    this.notePriority = map['notePriority'];
  }

  @override
  String toString() {
    return 'Notes{noteID: $noteID, categoryID: $categoryID, categoryTitle: $categoryTitle, noteTitle: $noteTitle, noteContent: $noteContent, noteDate: $noteDate, notePriority: $notePriority}';
  }
}
