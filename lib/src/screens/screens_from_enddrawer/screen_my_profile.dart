import 'package:flutter/material.dart';

class ScreenMyProfile extends StatelessWidget {
  const ScreenMyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
    );
  }
}