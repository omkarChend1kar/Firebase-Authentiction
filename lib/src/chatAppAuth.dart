import 'package:chat_app_auth/src/provider/provider.dart';
import 'package:chat_app_auth/src/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/chat_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/signup_screen.dart';
import 'services/auth_methods.dart';

class ChatAppAuth extends StatelessWidget {
  const ChatAppAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthMethods>(
          create: (_) => AuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthMethods>().onAuthStateChanged,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF0040FD),
            secondary: const Color(0xFFFFFFFF),
          ),
        ),
        home: const MigratebetWelcomeNLoggedIn(),
      ),
    );
  }
}

