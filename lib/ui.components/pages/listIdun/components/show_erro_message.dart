import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String erro) async {

  await Future.delayed(Duration.zero);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red.withOpacity(0.87),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      content: Text(
        erro,
        textAlign: TextAlign.center,
      ),
    ),
  );
}