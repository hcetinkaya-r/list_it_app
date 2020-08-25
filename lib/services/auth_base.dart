

import 'package:list_it_app/models/app_user.dart';

abstract class AuthBase {
  Future<AppUser> currentUser();

  Future<AppUser> signInAnonymously();

  Future<bool> signOut();
}
