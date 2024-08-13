import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/itemsProvider.dart';
import 'package:todo_list/controller/logoutController.dart';
import 'package:todo_list/views/addToListScreen.dart';
import 'package:todo_list/views/components.dart';
import 'package:todo_list/views/loginScreen.dart';

class MainScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  MainScreen({super.key, required this.imageUrl, required this.name});
  @override
  Widget build(BuildContext context) {
    Provider.of<Itemsprovider>(context, listen: false).refresh();
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Dashboard.png"),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Logout',
                            desc: 'are you sure you want to logout?',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              try {
                                userLogout();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Loginscreen()));
                              } catch (e) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Error occured while logging out',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                              }
                            },
                          )..show();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image(
                        image: NetworkImage(imageUrl),
                        height: 120,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Welcome $name",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Image(image: AssetImage("assets/images/girl.png")),
                    const SizedBox(
                      height: 24,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Todo  Tasks.",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 24),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 12, bottom: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Dairy  Tasks.",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Poppins",
                                      color: Colors.black.withOpacity(0.47),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.warning,
                                              animType: AnimType.rightSlide,
                                              title: 'Delete Selected Items',
                                              desc:
                                                  'are you sure you want to delete all selected items?',
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () {
                                                Provider.of<Itemsprovider>(
                                                        context,
                                                        listen: false)
                                                    .delete();
                                              },
                                            )..show();
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.black,
                                            size: 30,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Addtolistscreen()));
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Colors.black,
                                            size: 30,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                child: Consumer<Itemsprovider>(
                                  builder: (context, Itemsprovider, child) =>
                                      ListView.builder(
                                    itemCount: Itemsprovider.itemsList.length,
                                    itemBuilder: (context, index) {
                                      return ListViewItem(
                                          tempItem:
                                              Itemsprovider.itemsList[index],
                                          num: index);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            )));
  }
}
