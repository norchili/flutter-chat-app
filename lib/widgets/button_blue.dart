import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final Function()? onPresed;
  final String textBtn;
  const ButtonBlue({Key? key, required this.onPresed, required this.textBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue, elevation: 2.0, shape: const StadiumBorder()),
        child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
                child: Text(
              textBtn,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ))),
        onPressed: onPresed);
  }
}
