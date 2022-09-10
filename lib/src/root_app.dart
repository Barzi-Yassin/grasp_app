// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/routes/route_screens.dart';
import 'package:grasp_app/src/screens/auth/screen_signin.dart';
import 'package:grasp_app/src/screens/auth/screen_signup.dart';

// import 'package:grasp_app/src/screens/screen_subject_files.dart';

import 'package:grasp_app/src/screens/main_screens/screen_subjects.dart';
import 'package:grasp_app/src/screens/main_screens/screen_subject_files.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      // theme: ThemeData(
      //   primaryColor: Colors.cyan,
      // ),
      title: 'Grasp',
      home: const ScreenSignin(),

      // initialRoute: ,
      getPages: [
        GetPage(
            name: RouteScreens.routeMyProfile,
            page: () => const ScreenMyProfile()),
        GetPage(
            name: RouteScreens.routeFilterStars,
            page: () => const ScreenFilterStars()),
        GetPage(
            name: RouteScreens.routeFilterFavorites,
            page: () => const ScreenFilterFavorites()),
        GetPage(
            name: RouteScreens.routeGraspGuidance,
            page: () => const ScreenGraspGuidance()),
      ],

      // routes: {
        // RouteScreens.routeInit: (context) => ScreenSubjects(),
        // RouteScreens.routeSubjects: (context) => ScreenSubjects(),
        // RouteScreens.routeSubjectFiles: (context) =>  const ScreenSubjectFiles(),

        // RouteScreens.routeMyProfile: (context) => const ScreenMyProfile(),
        // RouteScreens.routeGraspGuidance: (context) =>
        //     const ScreenGraspGuidance(),

        // RouteScreens.routeFilterStars: (context) => const ScreenFilterStars(),
        // RouteScreens.routeFilterFavorites: (context) =>
        //     const ScreenFilterFavorites(),
        // RouteScreens.routeFilterImportants: (context) =>
        //     const ScreenFilterImportants(),
        // RouteScreens.routeFilterArchived: (context) =>
        //     const ScreenFilterArchived(),
      // },
    );
  }
}
