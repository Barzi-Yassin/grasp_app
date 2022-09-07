// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/models/grasp_user_model.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subjects/widget_subject_records.dart';
import 'package:grasp_app/src/screens/screen_subject_files.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenSubjects extends StatelessWidget {
  ScreenSubjects({Key? key, required this.theUser}) : super(key: key);

  final User theUser;

  final ServiceFirestore serviceFirestore = ServiceFirestore();

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
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: customeText(
                  theData: '${theUser.uid}\n${theUser.email}',
                  theFontSize: 20), //  TODO: temporary
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("subjects")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("err ${snapshot.error}");
                    } else if (snapshot.data == null || !snapshot.hasData) {
                      return const Text('snapshot is empty(StreamBuilder)');
                    }

                    // snapshot.data!.docs.first;
                    debugPrint('22222');
                    debugPrint(snapshot.data!.docs.length.toString());
                    debugPrint(snapshot.data.toString());

                    snapshot.data?.docs;

                    return ListView.builder(
                      // clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, theRecord) {
                        return WidgetSubjectRecords(
                            // subjectRecordName: datalistSubject[theRecord]
                            //         ["subject_name"]
                            //     .toString(),
                            subjectRecordName: snapshot.data!.docs[theRecord].data()["subjectName"],
                            subjectRecordItemsNumber: int.parse(
                              datalistSubject[theRecord]["subject_items_number"]
                                  .toString(),
                            ),
                            theRecord: theRecord);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dialogAdd(
          context: context,
          title: 'Subject',
          controller: controllerAddGraspSubject,
          theOnPressed: serviceFirestore.createSubject(
            user: theUser,
            theSubjectName: controllerAddGraspSubject.text,
            theSubjectItemsNumber: 1,
            theSubjectId: 1,
          ),
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
