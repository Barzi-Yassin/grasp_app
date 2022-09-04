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
        Get.snackbar('error', 'The password provided is too weak.');
        debugPrint('error :: The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('error', 'The account already exists for that email.');
        debugPrint('error :: The account already exists for that email.');
      } else {
        Get.snackbar('error', e.message.toString());
        debugPrint('error :: ${e.message}');
      }
    } catch (e) {
      Get.snackbar('error', e.toString());
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
        Get.snackbar('error', 'No user found for that email.');
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('error', 'Wrong password provided for that user.');
        debugPrint('Wrong password provided for that user.');
      } else {
        Get.snackbar('error', e.message.toString());
        debugPrint('error :: ${e.message}');
      }
    }
        return credential;

  }
}
