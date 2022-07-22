import 'package:flutter/material.dart';
import 'package:grasp_app/src/routes/route_screens.dart';

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
    return   MaterialApp(
      title: 'Grasp',
      // home: ScreenSubjects(),
      initialRoute: RouteScreens.routeInit,
      routes: {
        RouteScreens.routeInit: (context) => const ScreenSubjects(),
        RouteScreens.routeSubjects: (context) => const ScreenSubjects(),
        RouteScreens.routeSubjectFiles: (context) => const ScreenSubjectFiles(),
      },
    );
  }
}