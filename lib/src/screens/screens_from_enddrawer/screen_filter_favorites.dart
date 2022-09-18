import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subject_files/widget_subject_file_records.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenFilterFavorites extends StatelessWidget {
  ScreenFilterFavorites({Key? key, this.theUser}) : super(key: key);
  final User? theUser;

  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final CustomeStringFunctions customeStringFunctions =
      CustomeStringFunctions();
  final DateTimeOptimizer dateTimeOptimizer = DateTimeOptimizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(
        child: EndDrawer(theUser: theUser),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        leading: functionArrowbackIconButton(context),
        title: const Text('Favorites'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: serviceFirestore.firestoreInstance
                .collection("users2")
                .doc("O6fkMGCKFBSTMsPIfiDXjFjG47E3")
                .collection("favAndStars")
                .doc("favfiles")
                .collection("files")
                .orderBy("fileFavedOrStaredAt", descending: true)
                .snapshots(),
            builder: (context, snapshotFiles) {
              if (snapshotFiles.connectionState == ConnectionState.waiting) {
                return loadingIndicator();
              } else if (snapshotFiles.hasError) {
                return Text("err ${snapshotFiles.error}");
              } else if (snapshotFiles.data == null || !snapshotFiles.hasData) {
                return const Text('snapshotFiles is empty(StreamBuilder)');
              }

              // snapshotFiles.data!.docs.first;
              debugPrint('44444files');
              debugPrint(snapshotFiles.data!.docs.length.toString());
              debugPrint(snapshotFiles.data.toString());

              snapshotFiles.data?.docs;

              final int filesLength = snapshotFiles.data!.docs.length;

              if (filesLength == 0) {
                return customeText(theData: 'No files found!');
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 80),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshotFiles.data!.docs.length,
                  itemBuilder: (context, theRecord) {
                    final QueryDocumentSnapshot<Map<String, dynamic>>
                        theRecordItem = snapshotFiles.data!.docs[theRecord];

                    final String theRecordItemFileSubjectName =
                        theRecordItem.data()['fileSubjectName'];

                    final theRecordItemFileName =
                        theRecordItem.data()["fileName"];
                    final theRecordFileCreatedAt =
                        theRecordItem.data()["fileCreatedAt"];

                    final String theRecordItemFileNameAbbreviated =
                        customeStringFunctions.customeSubString(
                            theString: theRecordItemFileName,
                            theResultLengthLimit: 5);

                    // if (!listOfCurrentFilesName
                    //     .contains(theRecordItemFileName)) {
                    //   listOfCurrentFilesNameFunction()
                    //       .add(theRecordItemFileName);
                    // } // fix here dynamic

                    // final theRecordFileCreatedAtConverted =
                    //     DateTime.fromMillisecondsSinceEpoch(
                    //         theRecordFileCreatedAt); // // fix here dynamic

                    // var theRecordFileCreatedAtVarListBoilerPlate = {
                    //   'time': dateTimeOptimizer.dateTimeTwelveHourFormater(
                    //       hourNumber: theRecordFileCreatedAtConverted.hour,
                    //       minuteNumber: theRecordFileCreatedAtConverted.minute),
                    //   'date':
                    //       '${dateTimeOptimizer.dateTimeNumberToMonthName(monthNumber: theRecordFileCreatedAtConverted.month)}.${theRecordFileCreatedAtConverted.day}, ${theRecordFileCreatedAtConverted.year}',
                    // }; // fix here dynamic
                    return Column(
                      children: [
                        theRecord == 0
                            ? Container(
                                // height: 50,
                                height: 20,
                                alignment: Alignment.center,
                                // child: Row(
                                //   children: const [
                                //     Expanded(
                                //       child: Divider(
                                //         thickness: 1,
                                //         endIndent: 10,
                                //       ),
                                //     ),
                                //     Text(
                                //       // widget.theFileSubjectCreatedAt,
                                //       'ffff',
                                //       style: TextStyle(
                                //         color: Colors.black26,
                                //       ),
                                //     ),
                                //     Expanded(
                                //       child: Divider(
                                //         thickness: 1,
                                //         indent: 10,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              )
                            : const SizedBox(height: 0, width: 0),
                        WidgetSubjectFileRecords(
                          theUser: theUser!,
                          theFileName: theRecordItemFileName,
                          theFileSubjectName: theRecordItemFileSubjectName,
                          subjectFileRecordId: "${theRecord + 1}",
                          subjectFileRecordName: theRecordItemFileName,
                          subjectFileRecordTime: "subject",
                          // theRecordFileCreatedAtVarListBoilerPlate['time']
                          //     .toString(), // fix here dynamic
                          subjectFileRecordDate: theRecordItemFileSubjectName,
                          // theRecordFileCreatedAtVarListBoilerPlate['date']
                          //     .toString(),
                          theTrailingOnPressed: () {
                            Get.snackbar(
                              'Grasp caution',
                              'Sorry for that, editing grasp name doesn\'t implemented yet!',
                            );
                            // showAnimatedDialog(
                            //   barrierColor: Colors.black38,
                            //   barrierDismissible: true,
                            //   context: context,
                            //   animationType: DialogTransitionType.sizeFade,
                            //   curve: Curves.easeOut,
                            //   alignment: Alignment.bottomCenter,
                            //   duration: const Duration(milliseconds: 800),
                            //   builder: (_) => DialogEdit(
                            //     title: "Grasp",
                            //     fileNameOld: theRecordItemFileNameAbbreviated,
                            //     controller: controllerEditGraspFileName,
                            //     theOnPressed: () {},
                            //   ),
                            // );
                          },
                          theOnLongPress: () {},
                          // () async {
                          //   showAnimatedDialog(
                          //     barrierColor: Colors.black38,
                          //     barrierDismissible: true,
                          //     context: context,
                          //     animationType: DialogTransitionType.sizeFade,
                          //     curve: Curves.easeOut,
                          //     alignment: Alignment.bottomCenter,
                          //     duration: const Duration(milliseconds: 800),
                          //     builder: (_) => DialogDelete(
                          //       theTitle: "Grasp",
                          //       theName: theRecordItemFileName,
                          //       theOnPressed: () async {
                          //         await serviceFirestore
                          //             .deleteFile(
                          //           user: widget.theUser,
                          //           theFileSubjectName:
                          //               widget.theFileSubjectName,
                          //           theFileName: theRecordItemFileName,
                          //         )
                          //             .then(
                          //           (value) {
                          //             Get.back();
                          //             listOfCurrentFilesNameFunction()
                          //                 .remove(theRecordItemFileName);
                          //             serviceFirestore.updateSubject(
                          //                 user: widget.theUser,
                          //                 theSubjectName:
                          //                     widget.theFileSubjectName,
                          //                 theSubjectItemsNumber:
                          //                     listOfCurrentFilesName.length
                          //                         .toString());

                          //             Get.snackbar('Grasp caution',
                          //                 'The Grasp "$theRecordItemFileNameAbbreviated" has been deleted successfully.');
                          //             // debugPrint(
                          //             //     'jjjjjjjj delete :: ${listOfCurrentFilesName.length}'); // fix here dynamic
                          //           },
                          //         );
                          //       },
                          //     ),
                          //   );
                          // },
                        ),
                      ],
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
