// ignore_for_file: unused_import

import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/models/grasp_user_model.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subjects/widget_subject_records.dart';
import 'package:grasp_app/src/screens/screen_subject_files.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenSubjects extends StatefulWidget {
  const ScreenSubjects({Key? key, required this.theUser}) : super(key: key);

  final User theUser;

  @override
  State<ScreenSubjects> createState() => _ScreenSubjectsState();
}

class _ScreenSubjectsState extends State<ScreenSubjects> {
  final ServiceFirestore serviceFirestore = ServiceFirestore();

  // start listOfCurrentSubjectsName of the current subject names
  List<String> listOfCurrentSubjectsName = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listOfCurrentSubjectsName = <String>[];
  }

  List<String> listOfCurrentSubjectNames() {
    int len = listOfCurrentSubjectsName.length;
    debugPrint('There are $len elements in the listOfCurrentSubjectsName');
    return listOfCurrentSubjectsName;
  }
  // end listOfCurrentSubjectsName of the current subject names

  final TextEditingController controllerAddGraspSubject =
      TextEditingController();

  int subjectidLocal = 1000;

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
                  theData: '${widget.theUser.uid}\n${widget.theUser.email}',
                  theFontSize: 20), //  TODO: temporary
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  // collection("users").doc('subjects').collection(theSubjectId.toString()).doc(user.uid)
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.theUser.uid)
                      .collection('subjects')
                      .snapshots(),
                  // initialData: FirebaseFirestore.instance.collection("users").doc(widget.theUser.uid).collection("subjects").doc("sub 1").collection("files").snapshots(),
                  builder: (context, snapshotSubject) {
                    if (snapshotSubject.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshotSubject.hasError) {
                      return Text("err ${snapshotSubject.error}");
                    } else if (snapshotSubject.data == null ||
                        !snapshotSubject.hasData) {
                      return const Text(
                          'snapshotSubject is empty(StreamBuilder)');
                    }

                    // snapshotSubject.data!.docs.first;
                    debugPrint('22222');
                    debugPrint(snapshotSubject.data!.docs.length.toString());
                    debugPrint(snapshotSubject.data.toString());

                    snapshotSubject.data?.docs;

                    final int subjectLength = snapshotSubject.data!.docs.length;

                    if (subjectLength == 0) {
                      return customeText(theData: 'No subject found!');
                    } else {
                      return ListView.builder(
                        // clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshotSubject.data!.docs.length,
                        itemBuilder: (context, theRecord) {
                          final theRecordItem =
                              snapshotSubject.data!.docs[theRecord];
                          final theRecordSubjectName =
                              theRecordItem.data()["subjectName"];

                          if (!listOfCurrentSubjectsName.contains(theRecordSubjectName)) {
                            listOfCurrentSubjectNames()
                                .add(theRecordSubjectName);
                          }

                          return WidgetSubjectRecords(
                            theUser: widget.theUser,
                            theFileSubjectName: theRecordSubjectName,
                            theGetSubjectItemsLength: subjectLength
                                .toString(), // TODO: return files length using provider
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAnimatedDialog(
          barrierColor: Colors.black38,
          barrierDismissible: true,
          context: context,
          builder: (_) => DialogAdd(
            controller: controllerAddGraspSubject,
            title: 'Subject',
            theOnPressed: () async {
              // debugPrint(listOfCurrentSubjectsName.contains('sub1').toString());
              debugPrint(listOfCurrentSubjectsName.contains('sub1').toString());

              if (controllerAddGraspSubject.text.isNotEmpty) {
                if (!listOfCurrentSubjectsName.contains(controllerAddGraspSubject.text)) {
                  await serviceFirestore
                      .createSubject(
                        user: widget.theUser,
                        theSubjectName:
                            controllerAddGraspSubject.text, // TODO: dispose it
                        theSubjectItemsNumber: 1,
                        // theSubjectId: subjectidLocal++,
                        theSubjectId: 0,
                      )
                      .then(
                        (_) => Get.back(),
                      );
                } else {
                  debugPrint('the subject name is already exist !!!');
                  Get.snackbar(
                      'error', 'the subject name is already exist !!!');
                }
              } else {
                // Get.back();
                Get.snackbar('error', 'Give a name to the new subjects!');
              }
            },
          ),
          animationType: DialogTransitionType.sizeFade,
          curve: Curves.easeOut,
          alignment: Alignment.bottomCenter,
          duration: const Duration(milliseconds: 800),
        ),
        backgroundColor: Colors.cyan.shade700,
        elevation: 10,
        child: customeIcon(
          theIcon: Icons.create_new_folder,
          theColor: Colors.white,
          theSize: 031,
        ),
      ),
    );
  }
}
