import 'package:flutter/material.dart';
import 'package:grasp_app/src/data/subject_data_list.dart';
import 'package:grasp_app/src/widgets/subject_records.dart';

class SubjectFolders extends StatelessWidget {
  const SubjectFolders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        title: const Text('Subjects'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 189, 189, 189),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(110, 0, 171, 193),
              Color.fromARGB(255, 189, 189, 189),
            ],
          ),
        ),
        child: ListView.builder(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          scrollDirection: Axis.vertical,
          itemCount: subjectDataList.length,
          itemBuilder: (context, i) {
            return GraspRecords(
              subjectRecordName: subjectDataList[i]["subject_name"].toString(),
              subjectRecordItemsNumber: int.parse(
                  subjectDataList[i]["subject_items_number"].toString()),
            );
          },
        ),
      ),
    );
  }
}
