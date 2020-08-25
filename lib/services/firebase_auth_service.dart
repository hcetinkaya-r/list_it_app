import 'package:firebase_auth/firebase_auth.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  @override
  Future<AppUser> currentUser() async {
    try {

      return _userFromFirebase(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  AppUser _userFromFirebase(User user) {
    if (user == null) return null;
    return AppUser(userID: user.uid);
  }

  @override
  Future<AppUser> signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      print("ANONIM GIRIS HATA:" + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("SIGN OUT HATA:" + e.toString());
      return false;
    }
  }
}
