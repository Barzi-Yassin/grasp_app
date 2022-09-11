import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class ScreenMessages extends StatelessWidget {
  const ScreenMessages({
    super.key,
    required this.theUser,
    required this.theFileName,
    required this.theFileSubjectName,
  });

  final User theUser;
  final String theFileName;
  final String theFileSubjectName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sss = screenWidth - 15;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade700,
          centerTitle: true,
          title: Text('$theFileSubjectName / $theFileName'),
        ),
        body: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: double.infinity,
          width: double.infinity,
          decoration: backgroundGradientCyan(),
          child: Badge(
            // toAnimate: false,
            animationType: BadgeAnimationType.scale,
            // padding: const EdgeInsets.all(10),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Colors.grey.shade400,
            //     Colors.cyan.shade200,
            //   ],
            // ),
            elevation: 0,
            position: BadgePosition.topStart(start: 5, top: 10),
            // borderSide: const BorderSide(color: Colors.white60, width: 1),
            badgeColor: Colors.transparent,
            showBadge: true,
            badgeContent: Container(
              height: 60,
              width: screenWidth - 20,
              // child: customeText(theData: 'fffffff'),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
              ),
              child: customeIconButton(
                  theOnPressed: () {
                    debugPrint(screenWidth.toString());
                    debugPrint({screenWidth / 2}.toString());
                  },
                  theIcon: Icons.add),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5, top: 45, bottom: 5),
              // height: 200,
              // alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                border: Border.all(color: Colors.white60, width: 2.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
