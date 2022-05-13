// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

void showOtpBottomSheet({
  required BuildContext context,
  required TextEditingController otpController,
  required VoidCallback onPressed,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(width: 70, height: 5, color: Colors.grey.shade300),
          const SizedBox(
            height: 10,
          ),
          const Text('Enter 6 digit OTP'),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: onPressed,
            child: Container(
              width: 280,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade900,
                border: Border.all(
                  width: 2,
                  color: Colors.blue.shade500,
                ),
              ),
              // width: MediaQuery.of(context).size.width * 0.70,
              // height: MediaQuery.of(context).size.height * 0.1,
              child: const Center(
                child: Text(
                  'Verify OTP',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
