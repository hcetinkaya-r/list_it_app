import 'package:flutter/cupertino.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/repository/user_repository.dart';
import 'package:list_it_app/services/auth_base.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  AppUser _appUser;
  String emailErrorMessage;
  String passwordErrorMessage;

  AppUser get appUser => _appUser;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<AppUser> currentUser() async {
    try {
      state = ViewState.Busy;
      _appUser = await _userRepository.currentUser();
      return _appUser;
    } catch (e) {
      debugPrint("View modeldeki current user hata: " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  /*@override
  Future<AppUser> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _appUser = await _userRepository.signInAnonymously();
      return _appUser;
    } catch (e) {
      debugPrint("View modeldeki sign in anonymusly hata: " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }*/

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _appUser = null;
      return sonuc;
    } catch (e) {
      debugPrint("View modeldeki sign out hata: " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _appUser = await _userRepository.signInWithGoogle();
      return _appUser;
    } catch (e) {
      debugPrint("View modeldeki sign in with google hata: " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    if (_emailPasswordControl(email, password)) {
      try {
        state = ViewState.Busy;
        _appUser = await _userRepository.createUserWithEmailAndPassword(
            email, password);

        return _appUser;
      } finally {
        state = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
        state = ViewState.Busy;
        _appUser =
            await _userRepository.signInWithEmailAndPassword(email, password);
        return _appUser;
      } else
        return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailPasswordControl(String email, [String password]) {
    var result = true;
    if (password != null && password.length < 6) {
      passwordErrorMessage = "The password should be 6 characters at least";
      result = false;
    } else
      passwordErrorMessage = null;
    if (!email.contains('@')) {
      emailErrorMessage = "Invalid email";
      result = false;
    } else
      emailErrorMessage = null;
    return result;
  }

  @override
  Future<void> sendForgotPassword(String email) async {
    if (_emailPasswordControl(email)) {
      state = ViewState.Busy;
      await _userRepository.sendForgotPassword(email);
    }

    try {} catch (e) {
      debugPrint("View modeldeki send forgot password hata: " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<bool> updateUserName(String userID, String newUserName) async {
    state = ViewState.Busy;
    var result = await _userRepository.updateUserName(userID, newUserName);
    state=ViewState.Idle;
    return result;
  }
}
