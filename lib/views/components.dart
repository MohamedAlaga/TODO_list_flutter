import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/itemsProvider.dart';
import 'package:todo_list/models/item.dart';
import 'package:todo_list/views/editItemScreen.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({
    super.key,
    required this.text,
    required this.fun,
  });
  final String text;
  final void Function() fun;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: fun,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 13,
              fontFamily: "Poppins",
              color: Color.fromARGB(
                255,
                85,
                132,
                122,
              )),
        ));
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.fun,
  });
  final String text;
  final void Function() fun;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(
              255,
              85,
              132,
              122,
            )),
        width: 220,
        height: 44,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}

class NormalTextField extends StatelessWidget {
  NormalTextField({
    super.key,
    required this.hint,
    required this.controller,
  });
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          hintText: hint),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  PasswordTextField({
    super.key,
    required this.hint,
    required this.controller,
  });
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      enableSuggestions: false,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          hintText: hint),
    );
  }
}

class ListViewItem extends StatefulWidget {
  const ListViewItem({
    super.key,
    required this.tempItem,
    required this.num,
  });

  final Item tempItem;
  final int num;
  @override
  State<ListViewItem> createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Checkbox(
          value: widget.tempItem.isDone,
          onChanged: (bool? value) {
            Provider.of<Itemsprovider>(context, listen: false)
                .check(widget.num);
          },
          checkColor: const Color.fromARGB(
            255,
            85,
            132,
            122,
          ),
          activeColor: const Color.fromARGB(
            255,
            85,
            132,
            122,
          ),
        ),
        title: TextButton(style: ButtonStyle(alignment: Alignment.topLeft
        ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Edititemscreen(itemToEdite: widget.tempItem.name);
            }));
          },
          child: Text(
            widget.tempItem.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: "Poppins",
              fontSize: 13,
            ),
          ),
        ));
  }
}
