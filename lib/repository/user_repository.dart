import 'package:flutter/foundation.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/services/auth_base.dart';
import 'package:list_it_app/services/fake_auth_service.dart';
import 'package:list_it_app/services/fire_store_db_service.dart';
import 'package:list_it_app/services/firebase_auth_service.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();
  FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<AppUser> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      AppUser _appUser = await _firebaseAuthService.currentUser();
      return await _fireStoreDBService.readUser(_appUser.userID);


    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  /*@override
  Future<AppUser> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }*/

  @override
  Future<AppUser> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithGoogle();
    } else {
      AppUser _appUser = await _firebaseAuthService.signInWithGoogle();
      bool _result = await _fireStoreDBService.saveUser(_appUser);

      if (_result) {
        return await _fireStoreDBService.readUser(_appUser.userID);
      } else
        return null;
    }
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.createUserWithEmailAndPassword(
          email, password);
    } else {
      AppUser _appUser = await _firebaseAuthService
          .createUserWithEmailAndPassword(email, password);
      bool _result = await _fireStoreDBService.saveUser(_appUser);

      if (_result) {
        return await _fireStoreDBService.readUser(_appUser.userID);
      } else
        return null;
    }
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithEmailAndPassword(
          email, password);
    } else {
      AppUser _appUser = await _firebaseAuthService.signInWithEmailAndPassword(
          email, password);
      return await _fireStoreDBService.readUser(_appUser.userID);
    }
  }

  @override
  Future<void> sendForgotPassword(String email) async {
    if (appMode == AppMode.DEBUG) {
      await _fakeAuthenticationService.sendForgotPassword(email);
    } else {
      _firebaseAuthService.sendForgotPassword(email);
    }
  }

  Future<bool> updateUserName(String userID, String newUserName) async {
    if(appMode == AppMode.DEBUG){
      return false;
    }else{
      return await _fireStoreDBService.updateUserName(userID, newUserName);
    }

  }
}
