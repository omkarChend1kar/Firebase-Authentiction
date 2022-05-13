import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/chat_screen.dart';
import '../screens/welcome_screen.dart';

class MigratebetWelcomeNLoggedIn extends StatelessWidget {
  static const id = 'migrate_screen';
  const MigratebetWelcomeNLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    print(firebaseUser);
    return (firebaseUser == null) ? const WelcomeScreen() : const ChatScreen();
  }
}
