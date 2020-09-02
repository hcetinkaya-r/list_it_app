class Passwords {
  int passwordID;
  String registrationName;
  String password;
  String userName;


  Passwords({this.registrationName, this.password, this.userName});


  Passwords.withID(this.passwordID, this.registrationName, this.password,
      this.userName);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['passwordID'] = passwordID;
    map['registrationName'] = registrationName;
    map['password'] = password;
    map['userName'] = userName;
    return map;
  }

  Passwords.fromMap(Map<String, dynamic> map) {
    this.passwordID = map['passwordID'];
    this.registrationName = map['registrationName'];
    this.password = map['password'];
    this.userName = map['userName'];
  }

  @override
  String toString() {
    return 'Passwords{passwordID: $passwordID, registrationName: $registrationName, password: $password, userName: $userName}';
  }
}
