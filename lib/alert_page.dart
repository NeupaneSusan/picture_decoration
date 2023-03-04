import 'package:flutter/material.dart';

Future<void> showDialogBox(
    {required BuildContext context, required Widget child}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54,
    builder: (context) {
       
      return child;
    },
  );
}
