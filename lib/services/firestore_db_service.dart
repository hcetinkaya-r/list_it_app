import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/services/database_base.dart';

class FireStoreDBService implements DBBase {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(AppUser appUser) async {
    //Map _userToAddMap = appUser.toMap();

    /*_userToAddMap['createdAt'] = FieldValue.serverTimestamp();
    _userToAddMap['updatedAt'] = FieldValue.serverTimestamp();

    _userToAddMap.addAll((<String, dynamic>{
      'yeniAlan' : "yeniAlan",
    }));*/

    await _firestoreDB
        .collection('users')
        .doc(appUser.userID)
        .set(appUser.toMap());

    /*.set(_userToAddMap);*/
    /* DocumentSnapshot _appUserRead =
        await FirebaseFirestore.instance.doc("users/${appUser.userID}").get();
    Map _appUserInfRead = _appUserRead.data();
    AppUser _appUserInfReadObj = AppUser.fromMap(_appUserInfRead);
    print("Okunan AppUser nesnesi: " + _appUserInfReadObj.toString());*/

    return true;
  }

  @override
  Future<AppUser> readUser(String userID) async {
    DocumentSnapshot _appUserRead =
        await _firestoreDB.collection("users").doc(userID).get();
    Map<String, dynamic> _appUserInfReadMap = _appUserRead.data();

    AppUser _appUserInfReadObj = AppUser.fromMap(_appUserInfReadMap);
    print("Okunan app user nesnesi: " + _appUserInfReadObj.toString());
    return _appUserInfReadObj;
  }

  @override
  Future<bool> updateUserName(String userID, String newUserName) async {
    var users = await _firestoreDB
        .collection("users")
        .where("userName", isEqualTo: newUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firestoreDB
          .collection("users")
          .doc(userID)
          .update({'userName': newUserName});
      return true;
    }
  }

  @override
  Future<bool> updateProfilePhoto(String userID, String profilePhotoURL) async {

      await _firestoreDB
          .collection("users")
          .doc(userID)
          .update({'profilePhotoURL': profilePhotoURL});
      return true;
    }
  }

