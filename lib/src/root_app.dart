// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/routes/route_screens.dart';
import 'package:grasp_app/src/screens/auth/screen_signup.dart';

// import 'package:grasp_app/src/screens/screen_subject_files.dart';

import 'package:grasp_app/src/screens/screen_subjects.dart';
import 'package:grasp_app/src/screens/screen_subject_files.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_filter_archived.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_filter_favorites.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_filter_importants.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_filter_stars.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_grasp_guidance.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_my_profile.dart';

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // change to GetMaterialApp to use the get package
    return   const GetMaterialApp(
      debugShowCheckedModeBanner: true,
      // theme: ThemeData(
      //   primaryColor: Colors.cyan,
      // ),
      title: 'Grasp',
      home: ScreenSignup(),
      // initialRoute: RouteScreens.routeInit,
      // routes: {
      //   RouteScreens.routeInit: (context) => ScreenSubjects(),
      //   RouteScreens.routeSubjects: (context) => ScreenSubjects(),
      //   // RouteScreens.routeSubjectFiles: (context) =>  const ScreenSubjectFiles(),

      //   RouteScreens.routeMyProfile: (context) => const ScreenMyProfile(),
      //   RouteScreens.routeGraspGuidance: (context) => const ScreenGraspGuidance(),

      //   RouteScreens.routeFilterStars: (context) => const ScreenFilterStars(),
      //   RouteScreens.routeFilterFavorites: (context) => const ScreenFilterFavorites(),
      //   RouteScreens.routeFilterImportants: (context) => const ScreenFilterImportants(),
      //   RouteScreens.routeFilterArchived: (context) => const ScreenFilterArchived(),
      // },
    );
  }
}
