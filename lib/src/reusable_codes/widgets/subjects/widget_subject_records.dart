// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/routes/route_screens.dart';
import 'package:grasp_app/src/screens/screen_subjects.dart';
import 'package:grasp_app/src/screens/screen_subject_files.dart';
// import 'package:grasp_app/src/screens/screen_subject_files.dart'; // why ?

class WidgetSubjectRecords extends StatelessWidget {
  const WidgetSubjectRecords({
    Key? key,
    required this.subjectRecordName,
    required this.subjectRecordItemsNumber,
    required this.theRecord,
  }) : super(key: key);

  final String subjectRecordName;
  final int subjectRecordItemsNumber;
  // final String theName=subjectRecordName;
  // final String theName='';
  // theName = subjectRecordName;
  final int theRecord;
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
          // onTap: () => Navigator.pushNamed(
          //   context,
          //   RouteScreens.routeSubjectFiles,
          //   // arguments:
          // ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) =>  ScreenSubjectFiles(
                theRecordFromSubject: theRecord, 
              )),
              
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
          title: Text(
            subjectRecordName,
            style: const TextStyle(fontSize: 15),
            maxLines: 1,
          ),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$subjectRecordItemsNumber',
                style: const TextStyle(fontSize: 14, letterSpacing: 0.5),
              ),
              const Text(
                ' items',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
