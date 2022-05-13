import 'package:chat_app_auth/src/components/show_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/show_otp_dialog.dart';
import '../components/show_snackbar.dart';
import '../provider/provider.dart';
import '../screens/chat_screen.dart';
import '../screens/welcome_screen.dart';

class AuthMethods {
  final FirebaseAuth _auth;

  AuthMethods(this._auth);

  //To keep user logged in
  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  // Email Sign Up
  Future<void> signUpUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification(context);
      if (_auth.currentUser!.emailVerified) {
        // loginWithEmailnPass(email: email, password: password, context: context);
        // Navigator.pushReplacementNamed(context, MigratebetWelcomeNLoggedIn.id);
      }
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } on FirebaseAuthException catch (error) {
      // Need to work on custom messages using error.code
      showSnackBar(context, error.message!);
    }
  }

  Future<void> loginWithEmailnPass({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!_auth.currentUser!.emailVerified) {
        showSnackBar(context, 'Email is not verified');
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (error) {
      showSnackBar(context, error.message!);
    }
  }

  //otp verfication
  Future<void> otpVerification({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    TextEditingController otpController = TextEditingController();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.of(context).pop();
      },
      verificationFailed: (error) async {
        showSnackBar(context, error.message!);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        showOtpBottomSheet(
          context: context,
          otpController: otpController,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otpController.text.trim(),
            );
            await _auth.signInWithCredential(credential);
            Navigator.of(context).pop();
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //Google signin provider

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleuser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        //Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (error) {
      showSnackBar(context, error.message!);
    }
  }

  //Email verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "Email verification sent");
    } on FirebaseAuthException catch (error) {
      showSnackBar(context, error.message!);
    }
  }

  //Sign Out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (error) {
      showSnackBar(context, error.message!);
    }
  }
}
