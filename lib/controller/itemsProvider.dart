import 'package:flutter/material.dart';
import 'package:todo_list/controller/ItemsController.dart';
import 'package:todo_list/models/item.dart';

/// Provider class to manage the items list.
class Itemsprovider extends ChangeNotifier {
  List<Item> itemsList = [];
  Itemsprovider() {
    refresh();
  }

/// refresh the item list from the local database (hive)
  void refresh() async {
    itemsList = await localgetItems();
    notifyListeners();
  }

/// add item to the list
/// 
/// parameters:
/// - `temp`: string containing the task to add.
  void update(String temp) async {
    await SetItem(temp, false);
    itemsList = await localgetItems();
    notifyListeners();
  }

/// mark item to be done or not
/// 
/// parameters:
/// - `index`: index of the item to be marked.
  void check(int index) async {
    await localUpadateItem(index, !itemsList[index].isDone);
    itemsList = await localgetItems();
    notifyListeners();
  }

/// delete all the done items
  void delete() async {
    List<String> temp = [];
    for (int i = 0; i < itemsList.length; i++) {
      if (itemsList[i].isDone) {
        temp.add(itemsList[i].name);
      }
    }
    await remoteDeleteItem(temp);
    await localDeleteItem(temp);
    itemsList = await localgetItems();
    notifyListeners();
  }

/// modify the name of the item
/// 
/// parameters:
/// - `name`: string containing the old name of the item.
/// - `newName`: string containing the new name of the item.
  void modify(String name , String newName) async {
    await remoteModifyItem(name, newName);
    await localModifyItem(name, newName);
    itemsList = await localgetItems();
    notifyListeners();
  }
}

