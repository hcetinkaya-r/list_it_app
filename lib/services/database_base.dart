

import 'package:list_it_app/models/app_user.dart';

abstract class DBBase{

  Future<bool> saveUser(AppUser appUser);
  Future<AppUser> readUser(String userID);
  Future<bool> updateUserName(String userID, String newUserName);
  Future<bool> updateProfilePhoto(String userID, String profileURL);



}