import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptions {
 static String handleAuthError(FirebaseAuthException e) {
  String errorMessage = 'Sign-up failed.';

  switch (e.code) {
    case 'weak-password':
      errorMessage = 'The password provided is too **weak**.';
      break;
    case 'email-already-in-use':
      errorMessage = 'The account already exists for that **email** address.';
      break;
    case 'invalid-email':
      errorMessage = 'The email address is **not valid**.';
      break;
    case 'operation-not-allowed':
      errorMessage = 'Email/password accounts are not enabled.';
      break;
    default:
      errorMessage = 'An unknown Firebase error occurred: ${e.code}';
      break;
    
  }
  return errorMessage;
  }}