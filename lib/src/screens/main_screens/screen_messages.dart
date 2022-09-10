import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class ScreenMessages extends StatelessWidget {
  const ScreenMessages({super.key, required this.theUser, required this.theFileName,});

  final User theUser;
  final String theFileName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade700,
          centerTitle: true,
          title: Text(theFileName),
        ),
        body: Container(
          decoration: backgroundGradientCyan(),
          height: double.infinity,
          width: double.infinity,
          // color: Colors.grey,
        ),
      ),
    );
  }
}
