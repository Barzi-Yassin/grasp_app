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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan.shade400,
        elevation: 10,
        child: const FaIcon(
          FontAwesomeIcons.fileCirclePlus,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
 