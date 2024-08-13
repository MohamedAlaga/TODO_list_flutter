import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/models/item.dart';
import 'package:todo_list/models/stats.dart';
import 'package:todo_list/models/users.dart';

/// perfrom user logout for current user using Firebase Authentication.
/// 
/// description:
/// - This function performs user logout using Firebase Authentication.
/// - after successful logout, it clears the user data from the local database (hive).
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the log out succeded, 
///   or `false` if an error occurred.
Future<bool> userLogout() async {
  try {
    var statsbox = Hive.box<Stats>('statsBox');
    var usersBox = Hive.box<Users>('usersBox');
    var itemsBox = Hive.box<Item>('itemsBox');
    usersBox.clear();
    itemsBox.clear();
    statsbox.putAt(0, Stats(isFirstTime: false,isUserLoggedIn: false));
    var auth = FirebaseAuth.instance;
    await auth.signOut();
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}