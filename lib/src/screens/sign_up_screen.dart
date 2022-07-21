import 'package:flutter/material.dart';

class SignUpScreenView extends StatefulWidget {
  const SignUpScreenView({Key? key}) : super(key: key);

  @override
  State<SignUpScreenView> createState() => _SignUpScreenViewState();
}

class _SignUpScreenViewState extends State<SignUpScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        leading: const Icon(Icons.exit_to_app_rounded),
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      
    );
  }
}
