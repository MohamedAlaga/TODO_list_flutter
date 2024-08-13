import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/models/item.dart';

/// add item to remote database (fire store)
///
/// Parameters:
/// - `name`: string containing the task to add.
/// - 'isDone': boolean to check if the task is done or not.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item added successfully, 
///   or `false` if an error occurred.
Future<bool> remoteSetItem(String name, bool isDone) async {
  var auth = FirebaseAuth.instance;
  try {
    CollectionReference items = FirebaseFirestore.instance.collection('items');
    await items
        .add({'name': name, 'isDone': isDone, 'userId': auth.currentUser!.uid});
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

/// add item to local database (hive)
///
/// Parameters:
/// - `name`: string containing the task to add.
/// - 'isDone': boolean to check if the task is done or not.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item added successfully, 
///   or `false` if an error occurred.
Future<bool> localSetItem(String name, bool isDone) async {
  try {
    var itemsBox = Hive.box<Item>('itemsBox');
    itemsBox.add(Item(name: name, isDone: isDone));
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

/// set item to remote and local database
///
/// Parameters:
/// - `name`: string containing the task to add.
/// - 'isDone': boolean to check if the task is done or not.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item added successfully, 
///   or `false` if an error occurred.
Future<bool> SetItem(String name, bool isDone) async {
  bool remote = await remoteSetItem(name, isDone);
  bool local = await localSetItem(name, isDone);
  return remote && local;
}

/// update task status in local database (hive)
/// 
/// description:
/// - change the status of the task to done or not done
///
/// Parameters:
/// - `index`: index of the task in the list.
/// - 'isDone': boolean to check if the task is done or not.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item added successfully, 
///   or `false` if an error occurred.
Future<bool> localUpadateItem(int index, bool isDone) async {
  try {
    var itemsBox = Hive.box<Item>('itemsBox');
    Item item = itemsBox.getAt(index)!;
    item.isDone = isDone;
    itemsBox.putAt(index, item);
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

/// get all tasks from remote database (fire store) and add them to local database (hive)
/// 
/// Parameters:
/// - `userId`: the id of the user that owns the data.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item fetched successfully, 
///   or `false` if an error occurred.
Future<bool> remotegetItems(String userId) async {
  try {
    CollectionReference items = FirebaseFirestore.instance.collection('items');
    QuerySnapshot querySnapshot =
        await items.where('userId', isEqualTo: userId).get();
    var itemsBox = Hive.box<Item>('itemsBox');
    itemsBox.clear();
    querySnapshot.docs.forEach((element) {
      itemsBox.add(Item(name: element['name'], isDone: element['isDone']));
      print(element['name']);
    });
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

/// get all tasks from local database (hive)
///
/// Returns:
/// - A list of the items if the item fetched successfully, 
///   or `false` if an error occurred.
Future<List<Item>> localgetItems() async {
  try {
    var itemsBox = Hive.box<Item>('itemsBox');
    List<Item> items = [];
    for (int i = 0; i < itemsBox.length; i++) {
      items.add(itemsBox.getAt(i)!);
    }
    return items;
  } catch (e) {
    print("Error: $e");
    return [];
  }
}

/// delete item from remote database (fire store)
/// 
/// Parameters:
/// - `name`: a list of the name of the tasks to delete.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item fetched successfully, 
///   or `false` if an error occurred.
Future<bool> remoteDeleteItem(List<String> name) async {
  try {
    CollectionReference items = FirebaseFirestore.instance.collection('items');
    QuerySnapshot querySnapshot = await items.get();
    querySnapshot.docs.forEach((element) {
      if (name.contains(element['name'])) {
        element.reference.delete();
      }
    });
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

/// delete item from remote database (hive)
/// 
/// Parameters:
/// - `name`: a list of the name of the tasks to delete.
///
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item fetched successfully, 
///   or `false` if an error occurred.
Future<bool> localDeleteItem(List<String> name) async {
  try {
    var itemsBox = Hive.box<Item>('itemsBox');
    for (int i = 0; i < itemsBox.length; i++) {
      if (name.contains(itemsBox.getAt(i)!.name)) {
        itemsBox.deleteAt(i);
      }
    }
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

/// update item name in remote database (fire store)
/// 
/// Parameters:
/// - `name`: the name of the task to update.
/// - `newName`: the new name of the task.
/// 
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item fetched successfully,
///  or `false` if an error occurred.
Future<bool> remoteModifyItem(String name, String newName) async {
  try {
    CollectionReference items = FirebaseFirestore.instance.collection('items');
    QuerySnapshot querySnapshot = await items.get();
    querySnapshot.docs.forEach((element) {
      if (element['name'] == name) {
        element.reference.update({'name': newName});
      }
    });
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

/// update item name in local database (hive)
/// 
/// Parameters:
/// - `name`: the name of the task to update.
/// - `newName`: the new name of the task.
/// 
/// Returns:
/// - A `Future<bool>` that resolves to `true` if the item fetched successfully,
/// or `false` if an error occurred.
Future<bool> localModifyItem(String name, String newName) async {
  try {
    var itemsBox = Hive.box<Item>('itemsBox');
    for (int i = 0; i < itemsBox.length; i++) {
      if (itemsBox.getAt(i)!.name == name) {
        Item item = itemsBox.getAt(i)!;
        item.name = newName;
        itemsBox.putAt(i, item);
      }
    }
    return true;
  } catch (e) {
    print("Error: $e");
    return false;
  }
}