import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class ServiceAuth {
  //  methods to authenticate user using firebase auth

  // sign up method
  Future<UserCredential?> signUpUserWithEmailAndPassword(
      {required String signUpemail, required String signUppass}) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpemail,
        password: signUppass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        customeSnackbar(
            theTitle: 'Sign up caution',
            theMessage: 'The password provided is too weak.');
        debugPrint('error :: The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        customeSnackbar(
            theTitle: 'Sign up caution',
            theMessage: 'The account already exists for that email.');
        debugPrint('error :: The account already exists for that email.');
      } else {
        customeSnackbar(
            theTitle: 'Sign up caution', theMessage: e.message.toString());
        debugPrint('error :: ${e.message}');
      }
    } catch (e) {
      customeSnackbar(theTitle: 'Sign up caution', theMessage: e.toString());
      debugPrint(e.toString());
    }
    return credential;
  }

  Future<UserCredential?> signInUserWithEmailAndPassword(
      {required String signInemail, required String signInpass}) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInemail,
        password: signInpass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        customeSnackbar(
            theTitle: 'Sign in caution',
            theMessage: 'No user found for that email.');
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        //   customeSnackbar( theTitle:'Sign in caution', theMessage: 'Wrong password provided for that user.');
        customeSnackbar(
            theTitle: 'Sign in caution',
            theMessage: 'Sign in failed! try to focus on your inputs.');
        debugPrint('Wrong password provided for that user.');
      } else {
        customeSnackbar(
            theTitle: 'Sign in caution', theMessage: e.message.toString());
        debugPrint('error :: ${e.message}');
      }
    }
    return credential;
  }
}
