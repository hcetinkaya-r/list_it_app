

import 'package:list_it_app/models/app_user.dart';

abstract class DBBase{

  Future<bool> saveUser(AppUser appUser);


}