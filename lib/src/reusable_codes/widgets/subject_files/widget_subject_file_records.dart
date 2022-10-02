import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/main_screens/screen_messages.dart';

class WidgetSubjectFileRecords extends StatelessWidget {
  WidgetSubjectFileRecords({
    Key? key,
    required this.theUser,
    required this.theFileName,
    required this.theFileSubjectName,
    required this.subjectFileRecordId,
    required this.subjectFileRecordName,
    required this.subjectFileRecordTime,
    required this.subjectFileRecordDate,
    required this.theTrailingOnPressed,
    required this.theOnLongPress,
    required this.isSubtitleDate,
  }) : super(key: key);

  final User theUser;
  final String theFileName;
  final String theFileSubjectName;
  final theTrailingOnPressed;
  final theOnLongPress;
  final bool isSubtitleDate;

  final String subjectFileRecordId;
  final String subjectFileRecordName;
  final String subjectFileRecordTime;
  final String subjectFileRecordDate;

  final CustomeStringFunctions customeStringFunctions =
      CustomeStringFunctions();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 55.0,
        margin: const EdgeInsets.only(bottom: 10.0, left: 6.0, right: 6.0),
        padding: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: Colors.white.withOpacity(0.9),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 06.0,
            ),
          ],
        ),
        child: ListTile(
          onTap: () => Get.to(() => ScreenMessages(
                theUser: theUser,
                theFileName: theFileName,
                theFileSubjectName: theFileSubjectName,
                theFileCreatedAt:
                    '$subjectFileRecordTime • $subjectFileRecordDate',
              )),
          onLongPress: theOnLongPress,
          dense: true,
          iconColor: const Color.fromARGB(255, 0, 171, 193),
          // contentPadding: const EdgeInsets.only(top: 2, left: 30, bottom: 10),
          contentPadding: const EdgeInsets.only(top: 3.5, left: 30, bottom: 0),
          isThreeLine: true,
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          enableFeedback: true,
          enabled: true,
          visualDensity: const VisualDensity(vertical: 0),
          leading: customeText(
              theData: subjectFileRecordId,
              theColor: Colors.black54,
              theFontSize: 16),
          subtitle: SizedBox(height: 0),
          // customeText( theData:
          //   subjectFileRecordName,
          //   style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
          //   maxLines: 1,
          //   textAlign: TextAlign.start,
          // ),
          title: SizedBox(
            // color: Colors.amber.shade500,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0.5),
                    customeText(
                      theData: subjectFileRecordName.length < 20
                          ? subjectFileRecordName
                          : customeStringFunctions.customeSubString(
                              theString: subjectFileRecordName,
                              theResultLengthLimit: 20,
                            ),
                      theFontSize: 17,
                      // theLetterSpacing: 0.5,
                      theMaxLines: 1,
                      theColor: Colors.grey.shade700,
                      theTextAlign: TextAlign.start,
                      // theFontFamily: "MavenPro"
                      // theFontWeight: FontWeight.w500,
                    ),
                    // const SizedBox(height: 6),
                    customeText(
                      theData: isSubtitleDate
                          ? subjectFileRecordDate
                          : '$subjectFileRecordTime • $subjectFileRecordDate', // here maintenance
                      theColor: Colors.grey.shade600,
                      // theFontFamily: "MavenPro"
                    ),
                  ],
                ),
                customeIconButton(
                    // thePaddingBottom: ,
                    theOnPressed: theTrailingOnPressed,
                    theIcon: Icons.edit_note,
                    theSize: 30,
                    theAlignment: Alignment.center),
              ],
            ),
          ),
          // trailing: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          // customeIconButton(
          //     // thePaddingBottom: ,
          //     theOnPressed: theTrailingOnPressed,
          //     theIcon: Icons.edit_note,
          //     theSize: 25,
          //     theAlignment: Alignment.topCenter),
          //   ],
          // ),
        ),
      ),
    );
  }
}
