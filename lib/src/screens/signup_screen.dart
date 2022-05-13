import 'package:chat_app_auth/src/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const id = 'signup_screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser() async {
    context.read<AuthMethods>().signUpUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
    // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: device_width * 0.15,
                      vertical: device_width * 0.05,
                    ),
                    child: TextFormField(
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
                    child: TextFormField(
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
                    onTap: signUpUser,
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
                          'Sign up with Email',
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
                      const Text('Already have an account ?'),
                      TextButton(
                        onPressed: () {
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
                        child: const Text('Sign in'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
