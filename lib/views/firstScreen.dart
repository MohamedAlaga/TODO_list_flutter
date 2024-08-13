import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/models/stats.dart';
import 'package:todo_list/views/components.dart';
import 'package:todo_list/views/signupScreen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Home.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Image(image: AssetImage("assets/images/young_man.png")),
              const SizedBox(
                height: 44,
              ),
              const Text(
                "Get things done with TODo",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 36,
              ),
              const Text(
                "Welcome to ToDo, your go-to\nsolution for staying organized and maximizing productivity. Designed\nwith simplicity and efficiency\nin mind, our app helps\nyou manage your tasks.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(170, 0, 0, 0)),
              ),
              const SizedBox(
                height: 76,
              ),
              MainButton(
                  text: "Get Started",
                  fun: () async {
                    try {
                      var state = Hive.box<Stats>('statsBox');
                      await state
                          .add(Stats(isFirstTime: false, isUserLoggedIn: false));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    } catch (e) {
                      print(e);
                    }
                  }),
              const SizedBox(
                height: 88,
              )
            ],
          ),
        ),
      ),
    );
  }
}
