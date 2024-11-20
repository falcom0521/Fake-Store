import 'package:flutter/material.dart';


class ToastMessage{
static void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.blueGrey,
      elevation: 10,
            behavior: SnackBarBehavior.floating,
    ),
  );
}
}
