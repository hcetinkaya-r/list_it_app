import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/services/db_base.dart';

class FireStoreDBService implements DBBase {
  final FirebaseFirestore _firestoreAuth = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(AppUser appUser) async {
    Map _userToAddMap = appUser.toMap();

    /*_userToAddMap['createdAt'] = FieldValue.serverTimestamp();
    _userToAddMap['updatedAt'] = FieldValue.serverTimestamp();

    _userToAddMap.addAll((<String, dynamic>{
      'yeniAlan' : "yeniAlan",
    }));*/

    await _firestoreAuth
        .collection('users')
        .doc(appUser.userID)
        .set(appUser.toMap());
    /*.set(_userToAddMap);*/

    DocumentSnapshot _appUserRead =
        await FirebaseFirestore.instance.doc("users/${appUser.userID}").get();

    Map _appUserInfRead = _appUserRead.data();
    AppUser _appUserInfReadObj = AppUser.fromMap(_appUserInfRead);
    print("Okunan appUser nesnesi: " + _appUserInfReadObj.toString());

    return true;
  }
}
