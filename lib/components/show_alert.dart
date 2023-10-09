import 'package:flutter/material.dart';
Future<void> showAlertDialog({required context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog( // <-- SEE HERE
        title: const Text('Confirm Account'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Please check your email to confirm your account.',style: TextStyle(
                color: Colors.blueGrey
              ),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}