import 'package:flutter/material.dart';

void showOtpDialog({
  required BuildContext context,
  required TextEditingController otpController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: const Text('Enter Otp'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: otpController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text('Continue'),
        ),
      ],
    ),
  );
}
