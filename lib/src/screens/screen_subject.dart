import 'package:flutter/material.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/methods/functions.dart';
import 'package:grasp_app/src/widgets/end_drawer/end_drawer.dart';
import 'package:grasp_app/src/widgets/subject_records.dart';

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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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

