import 'package:flutter/material.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({Key? key}) : super(key: key);

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
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
