import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subTitle) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(subTitle),
              actions: <Widget>[
                MaterialButton(
                    child: const Text('Aceptar'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  }

  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subTitle),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Aceptar'),
                  onPressed: () => Navigator.pop(context))
            ],
          ));
}
