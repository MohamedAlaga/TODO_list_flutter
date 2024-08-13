import 'package:flutter/material.dart';
import 'package:todo_list/controller/forgetPasswordController.dart';
import 'package:todo_list/views/components.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final TextEditingController email = TextEditingController();
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
                    "Forgot Password?",
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
                    image: AssetImage("assets/images/boy_Searching.png"),
                    height: 172,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "write your email and we will send you a link to reset your password",
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
                    padding:const EdgeInsets.only(left: 24, right: 24),
                    child: NormalTextField(hint: "Enter your Email", controller: email),
                  ),
                  const SizedBox(height: 72),
                  MainButton(text: "Send Reset Email", fun: () async{
                    await ForgetPasswordEmail(email.text);
                    Navigator.pop(context);
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
