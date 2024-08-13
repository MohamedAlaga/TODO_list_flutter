import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/itemsProvider.dart';
import 'package:todo_list/controller/loginController.dart';
import 'package:todo_list/models/users.dart';
import 'package:todo_list/views/components.dart';
import 'package:todo_list/views/forgetPassword.dart';
import 'package:todo_list/views/mainScreen.dart';
import 'package:todo_list/views/signupScreen.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
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
                  "Welcome Back!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                const Image(image: AssetImage("assets/images/teacher.png")),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, right: 48.0),
                  child: NormalTextField(
                      hint: "Enter your Email address ", controller: email),
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, right: 48.0),
                  child: PasswordTextField(
                      hint: "Enter your Password", controller: password),
                ),
                const SizedBox(
                  height: 32,
                ),
                ClickableText(
                    text: "Forgot Password ?",
                    fun: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          ));
                    }),
                const SizedBox(
                  height: 32,
                ),
                MainButton(
                    text: "Sign In",
                    fun: () async {
                      try {
                        if (await UserLogin(
                                email.text, password.text) !=
                            "") {
                          var usersBox = Hive.box<Users>('usersBox');
                          var TempUser = usersBox.values.toList()[0];
                          Provider.of<Itemsprovider>(context, listen: false)
                              .refresh();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                      imageUrl: TempUser.UserImage.toString(),
                                      name: TempUser.userName.toString())));
                        }
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          desc:
                              'invaled login please check your email and password',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        )..show();
                      }
                    }),
                const SizedBox(
                  height: 52,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Dont have an account ?",
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Poppins",
                        color: Color.fromARGB(255, 66, 66, 66)),
                  ),
                  ClickableText(
                    text: "Sign Up",
                    fun: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ]),
                const SizedBox(
                  height: 28,
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
