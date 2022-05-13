import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
    ),
  );
}
