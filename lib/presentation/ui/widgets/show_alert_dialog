import 'package:flutter/material.dart';

void showAlertDialog({
  required BuildContext context,    
  required String title,
  required String content
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // default: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
