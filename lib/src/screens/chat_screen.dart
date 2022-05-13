import 'package:chat_app_auth/src/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const id = '/chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void signOut() {
    context.read<AuthMethods>().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: device_width,
          height: device_height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Logged In'),
              ),
              InkWell(
                onTap: signOut,
                child: Container(
                  width: device_width * 0.30,
                  height: device_height * 0.05,
                  color: const Color(0xFF0040FD),
                  child: const Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
