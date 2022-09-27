// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/routes/route_screens.dart';
import 'package:grasp_app/src/screens/main_screens/screen_subjects.dart';
import 'package:grasp_app/src/screens/main_screens/screen_subject_files.dart';

class WidgetSubjectRecords extends StatelessWidget {
  const WidgetSubjectRecords({
    Key? key,
    required this.theUser,
    required this.theFileSubjectName,
    required this.theSubjectItemsLength,
    required this.theLongPressed,
    required this.theFileSubjectCreatedAt,
    required this.theFileSubjectUpdatedAt,
  }) : super(key: key);

  final User theUser;
  final String theFileSubjectName;
  final String theSubjectItemsLength;
  final String theFileSubjectCreatedAt;
  final String theFileSubjectUpdatedAt;
  final theLongPressed;

  String generateSubjectItemsGramatically() {
    String result = "";
    if (theSubjectItemsLength == '0') {
      result = "empty";
    } else if (theSubjectItemsLength == '1') {
      result = " item  ";
    } else {
      result = " items";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: 55.0,
        margin: const EdgeInsets.only(bottom: 10.0, left: 6.0, right: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 06.0,
            ),
          ],
        ),
        child: ListTile(
          onLongPress: theLongPressed,
          onTap: () => Get.to(
            ScreenSubjectFiles(
              theUser: theUser,
              theFileSubjectName: theFileSubjectName,
              theFileSubjectCreatedAt: theFileSubjectCreatedAt,
              theFileSubjectUpdatedAt: theFileSubjectUpdatedAt,
            ),
          ),
          minVerticalPadding: 20,
          iconColor: const Color.fromARGB(255, 0, 171, 193),
          leading: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: FaIcon(
              // FontAwesomeIcons.solidFolderOpen,
              FontAwesomeIcons.solidFolderClosed,
              size: 20,
            ),
          ),
          title: customeText(
            theData: theFileSubjectName,
            theFontSize: 15,
            theMaxLines: 1,
          ),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              customeText(
                theData:
                    theSubjectItemsLength == '0' ? '' : theSubjectItemsLength,
                theFontSize: 14,
                theLetterSpacing: 0.5,
              ),
              customeText(
                theData: generateSubjectItemsGramatically(),
                theFontSize: 12,
                theLetterSpacing: 0.87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
