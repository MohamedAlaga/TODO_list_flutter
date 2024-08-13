import 'package:hive/hive.dart';
part 'item.g.dart';

/// data model for the items of the todo list.
/// 
/// description:
/// - This class is a data model for the items of the todo list.
/// - It contains the name of the item and a boolean to check if the item is done or not.
/// 
/// Attributes:
/// - `name`: string containing the name of the item.
/// - `isDone`: boolean to check if the item is done or not.
@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isDone;
  Item({required this.name, required this.isDone});

}