import 'package:flutter/material.dart';
// import 'package:grasp_app/src/screens/sign_up_screen_view.dart';
import 'package:grasp_app/src/screens/splash_screen_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Grasp',
      home: SplashScreenView(),
    );
  }
}