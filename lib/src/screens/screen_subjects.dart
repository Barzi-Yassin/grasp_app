// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/functions/functions.dart';
import 'package:grasp_app/src/screens/screen_subject_files.dart';
import 'package:grasp_app/src/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/widgets/widget_subject_records.dart';
// import 'package:grasp_app/src/widgets/widget_subject_records.dart';

class ScreenSubjects extends StatelessWidget {
  const ScreenSubjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SafeArea(
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
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: const Text('Adding Subject'),
              content: TextFormField(),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancle'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Create'),
                  child: const Text('Create'),
                ),
              ],
            ),
          );
        },
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
