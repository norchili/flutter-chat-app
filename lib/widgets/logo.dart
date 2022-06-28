import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170.0,
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            const Image(image: AssetImage('assets/tag-logo.png')),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
