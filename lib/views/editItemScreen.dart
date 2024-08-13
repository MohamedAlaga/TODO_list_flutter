import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/itemsProvider.dart';
import 'package:todo_list/views/components.dart';

class Edititemscreen extends StatelessWidget {
  Edititemscreen({super.key, required this.itemToEdite});
  final TextEditingController task = TextEditingController();
  final String itemToEdite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Home.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Edit Task ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  const Image(
                    image: AssetImage(
                      "assets/images/edite.png",
                    ),
                    height: 172,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "what will it be this time?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Poppins",
                        color: Color.fromARGB(
                          255,
                          85,
                          132,
                          122,
                        )),
                  ),
                  const SizedBox(height: 72),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: NormalTextField(
                        hint: "Enter your new task", controller: task),
                  ),
                  const SizedBox(height: 72),
                  MainButton(
                      text: "edit task",
                      fun: () {
                        try {
                          Provider.of<Itemsprovider>(context, listen: false)
                              .modify(itemToEdite, task.text);
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
