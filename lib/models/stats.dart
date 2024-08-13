import 'package:hive/hive.dart';
part 'stats.g.dart';

/// data model stats of the app to check if the user is logged in or not.
/// 
/// Attributes:
/// - `isFirstTime`: boolean to check if the user is using the app for the first time.
/// - `isUserLoggedIn`: boolean to check if the user is logged in or not.
@HiveType(typeId: 2)
class Stats {
  @HiveField(0)
  bool isFirstTime;
  @HiveField(1)
  bool isUserLoggedIn;
  Stats({required this.isFirstTime, required this.isUserLoggedIn});

}