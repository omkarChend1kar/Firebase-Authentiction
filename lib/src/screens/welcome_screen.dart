import 'package:chat_app_auth/src/screens/signin_screen.dart';
import 'package:chat_app_auth/src/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../provider/provider.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void googleSign() {
    context.read<AuthMethods>().signInWithGoogle(context);
    // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void otpSignIn() async {
    context.read<AuthMethods>().otpVerification(
        context: context, phoneNumber: '+91${phoneController.text.trim()}');
    // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    // Navigator.pushReplacementNamed(context, MigratebetWelcomeNLoggedIn.id);
  }

  @override
  Widget build(BuildContext context) {
    double device_width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: device_width,
              height: device_height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: device_width * 0.15,
                        vertical: device_height * 0.01),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            '+91',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: otpSignIn,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            'Sign in with OTP',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade300,
                            height: 2,
                            width: 140,
                          ),
                        ),
                        const Text('Or'),
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade300,
                            height: 2,
                            width: 140,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: googleSign,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade100,
                          ),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/google.png',
                                width: 30,
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceInOut,
                            type: PageTransitionType.rightToLeft,
                            child: const SigninScreen(),
                          ),
                          (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.shade100,
                          ),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Continue with Email',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              const Icon(Icons.email_outlined),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                    child: const Text('Don\'t have an account ?'),
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
