import 'dart:async';

import 'package:list_it_app/app/sqflite_database/database_helper.dart';
import 'package:list_it_app/models/passwords/password.dart';




class PasswordsBloc {
  PasswordsBloc() {
    getPass();
  }
  final _passwordController = StreamController<List<Passwords>>.broadcast();
  get passwords => _passwordController.stream;

  dispose() {
    _passwordController.close();
  }

  getPass() async {
    _passwordController.sink.add(await DatabaseHelper.db.getPasswordList());
  }

  addPass(Passwords password) {
    DatabaseHelper.db.addPassword(password);
    getPass();
  }
  updatePass(Passwords password) {
    DatabaseHelper.db.updatePassword(password);
    getPass();
  }
  deletePass(int id) {
    DatabaseHelper.db.deletePassword(id);
    getPass();
  }

  deleteAllPass() {
    DatabaseHelper.db.deleteAllPasswords();
    getPass();
  }
}
