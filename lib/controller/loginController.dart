import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/controller/ItemsController.dart';
import 'package:todo_list/models/stats.dart';
import 'package:todo_list/models/users.dart';

/// perform user login using Firebase Authentication.
/// 
/// description:
/// - This function performs user login using Firebase Authentication.
/// - after successful login, it stores the user data in the local database (hive).
///
/// Parameters:
/// - `email`: The email address of the user who wants to login.
/// - `password`: The password of the user who wants to login.
///
/// Returns:
/// - A `Future<bool>` that resolves to user token if the user logged in successfully, 
///   or `false` if an error occurred.
Future<String> UserLogin(String email, String password ,) async {
  try {
    var auth = FirebaseAuth.instance;
    var usersBox = Hive.box<Users>('usersBox');
    var statsbox = Hive.box<Stats>('statsBox');
    UserCredential UserData =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    String? Token = await auth.currentUser!.getIdToken();
    usersBox.clear();
    usersBox.add(Users(
        userName: UserData.user!.displayName!,
        UserImage: UserData.user!.photoURL!,
        UserToken: Token!));
    remotegetItems(auth.currentUser!.uid);
    statsbox.putAt(0, Stats(isFirstTime: false,isUserLoggedIn: true));
    return Token;
  } catch (e) {
    print("Error: $e");
    return "0";
  }
}
