import 'package:firebase_auth/firebase_auth.dart';

/// sign up user using Firebase Authentication.
/// 
/// description:
/// - This function performs user sign up using Firebase Authentication.
/// - after successful sign up, it stores user image uri and user name to user profile.
///
/// Parameters:
/// - `email`: The email address of the user who wants to sign up.
/// - `password`: The password of the user who wants to sign up.
/// - `name`: The name of the user who wants to sign up.
/// - `uri`: The uri of the user image who wants to sign up.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the user added successfully, 
///   or `false` if an error occurred.
Future<bool> userSignUp(String email, String password, String name, String uri) async {
  try {
    var auth = FirebaseAuth.instance;
    UserCredential User = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await User.user!.updateProfile(displayName: name, photoURL: uri);
    await User.user!.reload();
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}
