import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType keyboardInput;
  final bool isPasdword;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.placeholder,
      required this.textEditingController,
      this.keyboardInput = TextInputType.text,
      this.isPasdword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding:
          const EdgeInsets.only(left: 10.0, top: 5.0, right: 20.0, bottom: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: textEditingController,
        obscureText: isPasdword,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 12.0),
        autocorrect: false,
        keyboardType: keyboardInput,
        //obscureText: true,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder),
      ),
    );
  }
}
