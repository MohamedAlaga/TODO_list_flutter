import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/controller/signupController.dart';
import 'package:todo_list/views/components.dart';
import 'package:todo_list/views/loginScreen.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController image = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
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
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Welcome Onboard!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text(
                        "Let’s help you meet up your task",
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
                      const SizedBox(
                        height: 36,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: NormalTextField(
                            hint: "Enter your Full Name", controller: name),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: NormalTextField(
                          hint: "Enter your Email address ",
                          controller: email,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: NormalTextField(
                          hint: "Enter your Image URL",
                          controller: image,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: PasswordTextField(
                          hint: "Enter your Password",
                          controller: password,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: PasswordTextField(
                            hint: "Confirm your Password",
                            controller: confirmPassword),
                      ),
                      const SizedBox(
                        height: 54,
                      ),
                      MainButton(
                          text: "Sign Up",
                          fun: () async{try{
                            if (password.text == confirmPassword.text) {
                              if (await userSignUp(email.text, password.text, name.text,
                                  image.text))
                                  {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => Loginscreen()));
                                  } else{AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          desc:
                              'error occured',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        )..show();}
                            } else{AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          desc:
                              'passwords do not match',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        )..show();}
                          }catch(e){
                            print(e);
                          }
                          }),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  color: Color.fromARGB(255, 66, 66, 66)),
                            ),
                            ClickableText(
                              text: "Login",
                              fun: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Loginscreen()));
                              },
                            ),
                          ]),
                      const SizedBox(
                        height: 28,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
