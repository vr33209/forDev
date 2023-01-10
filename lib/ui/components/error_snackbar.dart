import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error) {
  // ignore: deprecated_member_use
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red[900],
    content: Text(
      error,
      textAlign: TextAlign.center,
    ),
  ));
}
