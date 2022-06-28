import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String accountText;
  final String sesionText;
  const Labels(
      {Key? key,
      required this.route,
      required this.accountText,
      required this.sesionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          accountText,
          style: const TextStyle(
              color: Colors.black54,
              fontSize: 15.0,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            sesionText,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
