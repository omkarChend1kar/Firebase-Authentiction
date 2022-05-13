import 'package:chat_app_auth/src/provider/provider.dart';
import 'package:chat_app_auth/src/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../services/auth_methods.dart';
import 'signup_screen.dart';
import 'welcome_screen.dart';

class SigninScreen extends StatefulWidget {
  static const id = 'signin_screen';
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() {
    context.read<AuthMethods>().loginWithEmailnPass(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
    // Navigator.pushReplac(context, MigratebetWelcomeNLoggedIn.id);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: device_width,
            height: device_height,
            child: Form(
              key: _formStateKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: device_width * 0.15,
                      vertical: device_width * 0.05,
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Id',
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: device_width * 0.15,
                      vertical: device_width * 0.01,
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: loginUser,
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
                          'Sign in with Email',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\' have an account ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.bounceInOut,
                                type: PageTransitionType.rightToLeft,
                                child: const SignUpScreen(),
                              ),
                              (route) => false);
                        },
                        child: Text('Sign up'),
                      ),
                    ],
                  ),
                  Text('or'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sign in with'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.bounceInOut,
                                type: PageTransitionType.rightToLeft,
                                child: const MigratebetWelcomeNLoggedIn(),
                              ),
                              (route) => false);
                        },
                        child: const Text('Otp'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
