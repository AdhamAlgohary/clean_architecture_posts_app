import 'package:flutter/material.dart';

class SnackbarMsg {
 static void showSnackBar(
      {required BuildContext context,
      required String msg,
      required bool isSuccessSnacBar}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isSuccessSnacBar ? Colors.green : Colors.redAccent,
    ));
  }
}
