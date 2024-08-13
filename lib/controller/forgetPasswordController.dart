import 'package:firebase_auth/firebase_auth.dart';

/// Sends a password reset email to the specified email address using Firebase Authentication.
///
/// Parameters:
/// - `email`: The email address of the user who wants to reset their password.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the password reset email was sent successfully, 
///   or `false` if an error occurred.

Future<bool> ForgetPasswordEmail(String email) async {
  try {
    var auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: email);
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}
