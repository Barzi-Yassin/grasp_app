// ignore_for_file: unused_local_variable

// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceAuth {

  //  methods to authenticate user using firebase auth

  // sign up method
  Future<UserCredential?> signUpUserWithEmailAndPassword(
      {required String signUpemail, required String signUppass}) async {
        UserCredential? credential;
    try {
       credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpemail,
        password: signUppass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Sign up caution', 'The password provided is too weak.');
        debugPrint('error :: The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Sign up caution', 'The account already exists for that email.');
        debugPrint('error :: The account already exists for that email.');
      } else {
        Get.snackbar('Sign up caution', e.message.toString());
        debugPrint('error :: ${e.message}');
      }
    } catch (e) {
      Get.snackbar('Sign up caution', e.toString());
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
        Get.snackbar('Sign in caution', 'No user found for that email.');
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // Get.snackbar('Sign in caution', 'Wrong password provided for that user.');
        Get.snackbar('Sign in caution', 'Sign in failed! try to focus on your inputs.');
        debugPrint('Wrong password provided for that user.');
      } else {
        Get.snackbar('Sign in caution', e.message.toString());
        debugPrint('error :: ${e.message}');
      }
    }
        return credential;

  }
}
