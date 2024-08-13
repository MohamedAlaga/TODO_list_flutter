import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/itemsProvider.dart';
import 'package:todo_list/models/item.dart';
import 'package:todo_list/models/stats.dart';
import 'package:todo_list/models/users.dart';
import 'package:todo_list/views/loginScreen.dart';
import 'package:todo_list/views/mainScreen.dart';
import 'firebase_options.dart';
import 'package:todo_list/views/firstScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(UsersAdapter());
  Hive.registerAdapter(StatsAdapter());
  await Hive.openBox<Item>('itemsBox');
  await Hive.openBox<Users>('usersBox');
  await Hive.openBox<Stats>('statsBox');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
  create: (context) => Itemsprovider(),
  child: const MyApp(),
));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getStatsList(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        } else {
          var stateList = snapshot.data ?? [];
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: stateList.isEmpty
                ? const FirstScreen()
                : (stateList[0].isUserLoggedIn &&
                        stateList[1].userName.isNotEmpty)
                    ? MainScreen(
                        imageUrl: stateList[1].UserImage,
                        name: stateList[1].userName)
                    : Loginscreen(),
          );
        }
      },
    );
  }

  Future<List<dynamic>> _getStatsList() async {
    var statsBox = Hive.box<Stats>('statsBox');
    var user = Hive.box<Users>('usersBox');
    if (statsBox.isNotEmpty && user.isNotEmpty) {
      return await [statsBox.getAt(0), user.getAt(0)];
    } else if (statsBox.isNotEmpty && !(user.isNotEmpty)) {
      return await [statsBox.getAt(0), Users(userName: '', UserImage: '',UserToken: '',)];
    } else {
      return [];
    }
  }
}
