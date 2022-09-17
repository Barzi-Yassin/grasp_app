// ignore_for_file: unused_import

import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/models/grasp_user_model.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/sort_subjects_function.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_delete.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subjects/widget_subject_records.dart';
import 'package:grasp_app/src/screens/main_screens/screen_subject_files.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenSubjects extends StatefulWidget {
  const ScreenSubjects({Key? key, required this.theUser}) : super(key: key);

  final User theUser;

  @override
  State<ScreenSubjects> createState() => _ScreenSubjectsState();
}

class _ScreenSubjectsState extends State<ScreenSubjects> {
  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final SortSubjectsFunctions sortSubjectsFunctions = SortSubjectsFunctions();
  final DateTimeOptimizer dateTimeOptimizer = DateTimeOptimizer();
  final CustomeStringFunctions customeStringFunctions =
      CustomeStringFunctions();

  // start listOfCurrentSubjectsName of the current subject names
  List<String> listOfCurrentSubjectsName = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listOfCurrentSubjectsName = <String>[];
  }

  List<String> listOfCurrentSubjectsNameFunction() {
    int len = listOfCurrentSubjectsName.length;
    debugPrint(
        'There are ${len + 1} subjects(s) in the listOfCurrentSubjectsName');
    return listOfCurrentSubjectsName;
  }
  // end listOfCurrentSubjectsName of the current subject names

  final TextEditingController controllerAddGraspSubject =
      TextEditingController();
  int sortingSubjetsNumber = 0;
  bool isSortDescending = false;

  @override
  Widget build(BuildContext context) {
    final String sortedSubjectsFieldName = sortSubjectsFunctions
        .sortSubjectsByFieldName(theSortingSubjectNumber: sortingSubjetsNumber);
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      endDrawer: SafeArea(
        child: EndDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            setState(() => sortingSubjetsNumber++);
            debugPrint(
                'sorts :: $sortingSubjetsNumber, $sortedSubjectsFieldName, \$ ');
          },
          onLongPress: () =>
              setState(() => isSortDescending = !isSortDescending),
          child: customeIcon(theIcon: Icons.sort),
        ),
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
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: serviceFirestore.firestoreInstance
                      .collection("users2")
                      .doc(widget.theUser.uid)
                      .collection('subjects')
                      .orderBy(sortedSubjectsFieldName,
                          descending: sortedSubjectsFieldName == "subjectName" ? !isSortDescending : isSortDescending)
                      .snapshots(),
                  builder: (context, snapshotSubject) {
                    if (snapshotSubject.connectionState ==
                        ConnectionState.waiting) {
                      return loadingIndicator();
                    } else if (snapshotSubject.hasError) {
                      return Text("err ${snapshotSubject.error}");
                    } else if (snapshotSubject.data == null ||
                        !snapshotSubject.hasData) {
                      return const Text('snapshotSubject is empty(StreamBuilder)');
                    }

                    // snapshotSubject.data!.docs.first;
                    debugPrint('22222subjects');
                    debugPrint(snapshotSubject.data!.docs.length.toString());
                    debugPrint(snapshotSubject.data.toString());

                    snapshotSubject.data?.docs;

                    final int subjectLength = snapshotSubject.data!.docs.length;

                    if (subjectLength == 0) {
                      return customeText(theData: 'No subject found!');
                    } else {
                      return ListView.builder(
                        // clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.only(top: 5.0, bottom: 70),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshotSubject.data!.docs.length,
                        itemBuilder: (context, theRecord) {
                          final theRecordItem =
                              snapshotSubject.data!.docs[theRecord];
                          final theRecordItemSubjectName =
                              theRecordItem.data()["subjectName"];
                          final int theRecordItemSubjectUpdatedAt =
                              theRecordItem.data()["subjectUpdateAt"];
                          final int theRecordItemSubjectCreatedAt =
                              theRecordItem.data()["subjectCreatedAt"];

                          final String theRecordItemSubjectCreatedAtReady =
                              dateTimeOptimizer.dateTimeGenerator(
                                  theTimeStamp: theRecordItemSubjectCreatedAt);
                          final String theRecordItemSubjectUpdatedAtReady =
                              dateTimeOptimizer.dateTimeGenerator(
                                  theTimeStamp: theRecordItemSubjectUpdatedAt);

                          final String theRecordItemSubjectNameAbbreviated =
                              customeStringFunctions.customeSubString(
                                  theString: theRecordItemSubjectName,
                                  theResultLengthLimit: 5);
                          if (!listOfCurrentSubjectsName
                              .contains(theRecordItemSubjectName)) {
                            listOfCurrentSubjectsNameFunction()
                                .add(theRecordItemSubjectName);
                          }

                          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: serviceFirestore.firestoreInstance
                                  .collection("users2")
                                  .doc(widget.theUser.uid)
                                  .collection("subjects")
                                  .doc(theRecordItemSubjectName)
                                  .collection("files")
                                  .snapshots(),
                              builder: (context, snapshotFiles) {
                                if (snapshotFiles.connectionState ==
                                    ConnectionState.waiting) {
                                  return loadingIndicator(theColor: Colors.transparent);
                                } else if (snapshotFiles.hasError) {
                                  return Text("err ${snapshotFiles.error}");
                                } else if (snapshotFiles.data == null ||
                                    !snapshotFiles.hasData) {
                                  return const Text(
                                      'snapshotFiles is empty(StreamBuilder)');
                                }

                                debugPrint('44444files');
                                debugPrint(
                                    snapshotFiles.data!.docs.length.toString());
                                debugPrint(snapshotFiles.data.toString());

                                snapshotFiles.data?.docs;

                                final int filesLength =
                                    snapshotFiles.data!.docs.length;

                                return Column(
                                  children: [
                                    theRecord == 0
                                        ? Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children:  [
                                                const Expanded(
                                                  child: Divider(
                                                    thickness: 1,
                                                    endIndent: 10,
                                                  ),
                                                ),
                                                Text(
                                                  sortSubjectsFunctions.getSortName(theSortedSubjectsFieldName: sortedSubjectsFieldName),
                                                  style: const TextStyle(
                                                    color: Colors.black26,
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: Divider(
                                                    thickness: 1,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                ),
                                                Text(
                                                  sortSubjectsFunctions.getSortAscOrDesc(isSortDescending: isSortDescending),
                                                  style: const TextStyle(
                                                    color: Colors.black26,
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: Divider(
                                                    thickness: 1,
                                                    indent: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(height: 0, width: 0),
                                    WidgetSubjectRecords(
                                      theUser: widget.theUser,
                                      theFileSubjectName: theRecordItemSubjectName,
                                      theSubjectItemsLength: filesLength.toString(),
                                      theFileSubjectCreatedAt:
                                          theRecordItemSubjectCreatedAtReady,
                                      theFileSubjectUpdatedAt:
                                          theRecordItemSubjectUpdatedAtReady,
                                      theLongPressed: () async {
                                        if (filesLength == 0) {
                                          showAnimatedDialog(
                                            barrierColor: Colors.black38,
                                            barrierDismissible: true,
                                            context: context,
                                            animationType:
                                                DialogTransitionType.sizeFade,
                                            curve: Curves.easeOut,
                                            alignment: Alignment.bottomCenter,
                                            duration:
                                                const Duration(milliseconds: 800),
                                            builder: (_) => DialogDelete(
                                              theTitle: "Subject",
                                              theName: theRecordItemSubjectName,
                                              theOnPressed: () async {
                                                await serviceFirestore
                                                    .deleteSubject(
                                                  user: widget.theUser,
                                                  theSubjectName:
                                                      theRecordItemSubjectName,
                                                )
                                                    .then((value) {
                                                  Get.back();
                                                  listOfCurrentSubjectsNameFunction()
                                                      .remove(
                                                          theRecordItemSubjectName);
                                                  Get.snackbar('Subject caution',
                                                      'The subject "$theRecordItemSubjectNameAbbreviated" has been deleted successfully.');
                                                });
                                              },
                                            ),
                                          );
                                        } else {
                                          Get.snackbar('Subject caution',
                                              'Delete all the grasps inside "$theRecordItemSubjectNameAbbreviated" subject, then it could be deleted.');
                                        }
                                      },
                                    ),
                                  ],
                                );
                              });
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
              debugPrint(listOfCurrentSubjectsName
                  .contains(controllerAddGraspSubject.text)
                  .toString());

              if (controllerAddGraspSubject.text.isNotEmpty) {
                if (!listOfCurrentSubjectsName
                    .contains(controllerAddGraspSubject.text)) {
                  await serviceFirestore
                      .createSubject(
                        user: widget.theUser,
                        theSubjectName:
                            controllerAddGraspSubject.text, // TODO: dispose it
                      )
                      .then(
                        (_) => Get.back(),
                      );
                } else {
                  debugPrint('the subject name is already exist !!!');
                  Get.snackbar(
                      'Subject caution', 'The subject name is already exist!');
                }
              } else {
                // Get.back();
                Get.snackbar(
                    'Subject caution', 'Give a name to the new subjects!');
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
