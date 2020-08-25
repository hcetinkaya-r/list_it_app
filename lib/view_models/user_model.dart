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


  AppUser get appUser => _appUser;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel(){
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

  @override
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
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _appUser=null;
      return sonuc;
    } catch (e) {
      debugPrint("View modeldeki sign out hata: " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }
}
