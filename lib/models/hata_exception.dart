
class Errors {
  String errorCode;

  static String showError(String errorCode) {

    switch (errorCode) {
      case 'email-already-in-use':
        return "This e-mail address is already in use, please use a different e-mail address.";

      case 'user-not-found':
        return "This user is not available in the system. Please create user first";

      default:
        return "Something went wrong";
    }
  }
}