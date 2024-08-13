import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/itemsProvider.dart';
import 'package:todo_list/views/components.dart';

class Addtolistscreen extends StatelessWidget {
  Addtolistscreen({super.key});
  final TextEditingController task = TextEditingController();
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
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  const Image(image: AssetImage("assets/images/couple.png")),
                  const SizedBox(height: 32),
                  const Text(
                    "Add What your want to do later on..",
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
                        hint: "Enter your task", controller: task),
                  ),
                  const SizedBox(height: 72),
                  MainButton(
                      text: "Add to list",
                      fun: (){
                        try {
                          Provider.of<Itemsprovider>(context, listen: false)
                              .update(task.text);
                          Navigator.pop(context);
                        }catch(e){
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
