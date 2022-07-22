import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:grasp_app/src/screens/screen_sign_up.dart';
// ignore: unused_import
import 'package:grasp_app/src/screens/screen_splash.dart';
import 'package:grasp_app/src/screens/screen_subject_files.dart';

// ignore: unused_import
import 'package:grasp_app/src/screens/screen_subject.dart';

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Grasp',
      home: ScreenSubjectFiles(),
    );
  }
}