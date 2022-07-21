import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:grasp_app/src/screens/sign_up_screen.dart';
// ignore: unused_import
import 'package:grasp_app/src/screens/splash_screen.dart';

import 'package:grasp_app/src/screens/subject_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Grasp',
      home: SubjectFolders(),
    );
  }
}