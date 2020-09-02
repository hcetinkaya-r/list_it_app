import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/services/firebase/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  @override
  Future<AppUser> currentUser() async {
    try {
      return _userFromFirebase(user);
    } catch (e) {
      print("firebase auth service current user hata: " + e.toString());
      return null;
    }
  }

  AppUser _userFromFirebase(User user) {
    if (user == null) return null;
    return AppUser(userID: user.uid, email: user.email);
  }

  /*@override
  Future<AppUser> signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      print("firebase auth service sign in anonymously hata: " + e.toString());
      return null;
    }
  }*/

  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("firebase auth service sign out hata:" + e.toString());
      return false;
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));

        User _user = userCredential.user;

        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);


  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);


  }

  @override
  // ignore: missing_return
  Future<void> sendForgotPassword(String email) async {

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

    } catch (e) {
      print("firebase auth service send forgot password hata: " + e.toString());

    }


  }
}
