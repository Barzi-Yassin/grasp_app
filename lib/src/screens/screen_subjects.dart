// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subjects/widget_subject_records.dart';
import 'package:grasp_app/src/screens/screen_subject_files.dart';

class ScreenSubjects extends StatelessWidget {
  ScreenSubjects({Key? key}) : super(key: key);

  final TextEditingController controllerAddGraspSubject =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(
        child: EndDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        title: const Text('Subjects'),
        // actions: [
        //   Icon(Icons.add),
        //   Icon(Icons.add),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: ListView.builder(
          // clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          scrollDirection: Axis.vertical,
          itemCount: datalistSubject.length,
          itemBuilder: (context, theRecord) {
            return WidgetSubjectRecords(
                subjectRecordName:
                    datalistSubject[theRecord]["subject_name"].toString(),
                subjectRecordItemsNumber: int.parse(
                  datalistSubject[theRecord]["subject_items_number"].toString(),
                ),
                theRecord: theRecord);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dialogAdd(
          context: context,
          title: 'Subject',
          controller: controllerAddGraspSubject,
        ),
        backgroundColor: Colors.cyan.shade700,
        elevation: 10,
        child: const Icon(
          Icons.create_new_folder,
          color: Colors.white,
          size: 29,
        ),
      ),
    );
  }
}
