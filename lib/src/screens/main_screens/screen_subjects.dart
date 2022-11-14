import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/sort_subjects_function.dart';
import 'package:grasp_app/src/reusable_codes/widgets/buttons/widget_switch_button_change_theme.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_delete.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subjects/widget_subject_records.dart';
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
    // int len = listOfCurrentSubjectsName.length;
    // debugPrint(
    //     'There are ${len + 1} subjects(s) in the listOfCurrentSubjectsName');
    return listOfCurrentSubjectsName;
  }
  // end listOfCurrentSubjectsName of the current subject names

  final TextEditingController controllerAddGraspSubject =
      TextEditingController();
  int sortingSubjetsNumber = 0;
  bool isSortDescending = true;

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final String sortedSubjectsFieldName = sortSubjectsFunctions
        .sortSubjectsByFieldName(theSortingSubjectNumber: sortingSubjetsNumber);
    return Scaffold(
      // backgroundColor: Colors.grey.shade400,
      endDrawer: SafeArea(
        child: EndDrawer(theUser: widget.theUser),
      ),
      appBar: AppBar(
        // backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            setState(() => sortingSubjetsNumber++);
            // debugPrint(
            //     'sorts :: $sortingSubjetsNumber, $sortedSubjectsFieldName, \$ ');
          },
          onLongPress: () =>
              setState(() => isSortDescending = !isSortDescending),
          child: customeIcon(theIcon: Icons.sort),
        ),
        title: customeText(theData: 'Subjects'), // change to custome widgets
        actions: [
          widgetSwitchButtonChangeTheme(),
        ],
        // actions: [
        //   Icon(Icons.add),
        //   Icon(Icons.add),
        // ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: serviceFirestore.firestoreInstance
                      .collection("users")
                      .doc(widget.theUser.uid)
                      .collection('subjects')
                      .orderBy(sortedSubjectsFieldName,
                          descending: sortedSubjectsFieldName == "subjectName"
                              ? !isSortDescending
                              : isSortDescending)
                      .snapshots(),
                  builder: (context, snapshotSubject) {
                    if (snapshotSubject.connectionState ==
                        ConnectionState.waiting) {
                      return loadingIndicator();
                    } else if (snapshotSubject.hasError) {
                      return customeText(
                          theData:
                              "err ${snapshotSubject.error}"); // to fix to a formal output on ui. and others as well, to get the error make the firestore rule to false.
                      // [cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
                    } else if (snapshotSubject.data == null ||
                        !snapshotSubject.hasData) {
                      return customeText(
                          theData: 'snapshotSubject is empty(StreamBuilder)');
                    }

                    // // snapshotSubject.data!.docs.first;
                    // debugPrint('22222subjects');
                    // debugPrint(snapshotSubject.data!.docs.length.toString());
                    // debugPrint(snapshotSubject.data.toString());

                    snapshotSubject.data?.docs;

                    final int subjectLength = snapshotSubject.data!.docs.length;

                    if (subjectLength == 0) {
                      return noItemFound(
                        theItemName: 'Subject',
                        theScreenHeight: screenHeight,
                      );
                    } else {
                      return ListView.builder(
                        // clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 70, left: 9, right: 9),
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

                          return StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                              stream: serviceFirestore.firestoreInstance
                                  .collection("users")
                                  .doc(widget.theUser.uid)
                                  .collection("subjects")
                                  .doc(theRecordItemSubjectName)
                                  .collection("files")
                                  .snapshots(),
                              builder: (context, snapshotFiles) {
                                if (snapshotFiles.connectionState ==
                                    ConnectionState.waiting) {
                                  return loadingIndicator(
                                      theColor: Colors.transparent);
                                } else if (snapshotFiles.hasError) {
                                  return customeText(
                                      theData: "err ${snapshotFiles.error}");
                                } else if (snapshotFiles.data == null ||
                                    !snapshotFiles.hasData) {
                                  return customeText(
                                      theData:
                                          'snapshotFiles is empty(StreamBuilder)');
                                }

                                // debugPrint('44444files');
                                // debugPrint(
                                //     snapshotFiles.data!.docs.length.toString());
                                // debugPrint(snapshotFiles.data.toString());

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
                                              children: [
                                                const Expanded(
                                                  child: Divider(
                                                    thickness: 1,
                                                    endIndent: 10,
                                                  ),
                                                ),
                                                customeText(
                                                  theData: sortSubjectsFunctions
                                                      .getSortName(
                                                          theSortedSubjectsFieldName:
                                                              sortedSubjectsFieldName),
                                                  theColor: Colors.black26,
                                                ),
                                                const Expanded(
                                                  child: Divider(
                                                    thickness: 1,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                ),
                                                customeText(
                                                  theData: sortSubjectsFunctions
                                                      .getSortAscOrDesc(
                                                          isSortDescending:
                                                              isSortDescending),
                                                  theColor: Colors.black26,
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
                                      theFileSubjectName:
                                          theRecordItemSubjectName,
                                      theSubjectItemsLength:
                                          filesLength.toString(),
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
                                            duration: const Duration(
                                                milliseconds: 800),
                                            builder: (_) => DialogDelete(
                                              theTitle: "Subject",
                                              theName:
                                                  theRecordItemSubjectNameAbbreviated,
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
                                                  customeSnackbar(
                                                    theTitle: 'Subject caution',
                                                    theMessage:
                                                        'The subject "$theRecordItemSubjectNameAbbreviated" has been deleted successfully.',
                                                  );
                                                });
                                              },
                                            ),
                                          );
                                        } else {
                                          customeSnackbar(
                                            theTitle: 'Subject caution',
                                            theMessage:
                                                'Delete all the grasps inside "$theRecordItemSubjectNameAbbreviated" subject, then it could be deleted.',
                                          );
                                          // debugPrint('eeeeeeee :: $theRecordItemSubjectNameAbbreviated');
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
              // debugPrint(listOfCurrentSubjectsName
              //     .contains(controllerAddGraspSubject.text)
              //     .toString());

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
                  // debugPrint('the subject name is already exist !!!');
                  customeSnackbar(
                    theTitle: 'Subject caution',
                    theMessage: 'The subject name is already exist!',
                  );
                }
              } else {
                // Get.back();
                customeSnackbar(
                  theTitle: 'Subject caution',
                  theMessage: 'Give a name to the new subjects!',
                );
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
