import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/services/firebase/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "123456";

  @override
  Future<AppUser> currentUser() async {
    return await Future.value(AppUser(userID: userID, email: "fakeuser@fake.com"));
  }

  /*@override
  Future<AppUser> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2), () => AppUser(userID: userID, email: "fakeuser@fake.com"));
  }*/

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2), () => AppUser(userID: "Google user id: 654321", email: "fakeuser@fake.com"));
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    return await Future.delayed(Duration(seconds: 2),
        () => AppUser(userID: "Email and password created user id: 123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    return await Future.delayed(Duration(seconds: 2),
        () => AppUser(userID: "Email password sign in user id: 123456",email: "fakeuser@fake.com"));
  }

  @override
  Future<void> sendForgotPassword(String email) {
    // TODO: implement sendForgotPassword
    throw UnimplementedError();
  }
}
