import 'package:hive/hive.dart';
part 'users.g.dart';

/// data model users of the app to store user data.
/// 
/// Attributes:
/// - `userName`: string containing the name of the user.
/// - `UserImage`: string containing the image of the user.
/// - `UserToken`: string containing the token of the user.
@HiveType(typeId: 1)
class Users {
  @HiveField(0)
  String userName;
  @HiveField(1)
  String UserImage;
  @HiveField(2)
  String UserToken;
  Users({required this.userName, required this.UserImage, required this.UserToken});

}