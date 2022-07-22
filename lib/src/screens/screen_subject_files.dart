// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/data/datalist_subject_files.dart';
import 'package:grasp_app/src/methods/functions.dart';
import 'package:grasp_app/src/widgets/subject_file_records.dart';
import 'package:grasp_app/src/widgets/subject_records.dart';

class ScreenSubjectFiles extends StatelessWidget {
  const ScreenSubjectFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        title: const Text('Programming Fund'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        height: double.infinity,
        width: double.infinity,
        decoration: cyanBackgroundGradient(),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          scrollDirection: Axis.vertical,
          itemCount: datalistSubjectFiles.length,
          itemBuilder: (context, theRecord) {
            return WidgetSubjectFileRecords(
              subjectFileRecordId: "${theRecord+1}",
              subjectFileRecordName: datalistSubjectFiles[theRecord]["subject_file_name"].toString(),
              subjectFileRecordTime: datalistSubjectFiles[theRecord]["subject_file_time"].toString(),
              subjectFileRecordDate: datalistSubjectFiles[theRecord]["subject_file_date"].toString(),
              // subjectRecordFileItemsNumber: int.parse(
              //     datalistSubjectFiles[theRecord]["subject_items_number"].toString()),
            );
          },
        ),
      ),
    );
  }
}

/*
ClipRRect(
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
          minVerticalPadding: 20,
          iconColor: const Color.fromARGB(255, 0, 171, 193),
          leading: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: FaIcon(
              FontAwesomeIcons.solidFolderOpen,
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
    )
 */