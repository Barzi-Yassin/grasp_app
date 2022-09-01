// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceAuth {
  //  methods to authenticate user using firebase auth

  // sign up method
  Future<void> signUpUserWithEmailAndPassword(
      {required String signUpemail, required String signUppass}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpemail,
        password: signUppass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signInUserWithEmailAndPassword(
      {required String signInemail, required String signInpass}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInemail,
        password: signInpass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }
}
