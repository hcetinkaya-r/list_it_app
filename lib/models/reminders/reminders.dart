class Reminders {
  int reminderID;
  String reminderTitle;
  String reminderContent;
  String reminderDate;
  String reminderTime;

  Reminders(this.reminderTitle, this.reminderContent, this.reminderDate,
      this.reminderTime);

  Reminders.withID(this.reminderID, this.reminderTitle, this.reminderContent,
      this.reminderDate, this.reminderTime);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['reminderID'] = reminderID;
    map['reminderTitle'] = reminderTitle;
    map['reminderDate'] = reminderDate;
    map['reminderTime'] = reminderTime;
    map['reminderContent'] = reminderContent;

    return map;
  }

  Reminders.fromMap(Map<String, dynamic> map) {
    this.reminderID = map['reminderID'];
    this.reminderTitle = map['reminderTitle'];
    this.reminderDate = map['reminderDate'];
    this.reminderTime = map['reminderTime'];
    this.reminderContent = map['reminderContent'];
  }

  @override
  String toString() {
    return 'Reminders{reminderID: $reminderID, reminderTitle: $reminderTitle, reminderContent: $reminderContent, reminderDate: $reminderDate, reminderTime: $reminderTime}';
  }
}
