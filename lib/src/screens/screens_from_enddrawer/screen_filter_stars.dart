import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_unfav_unstar_grasp_files.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subject_files/widget_subject_file_records.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenFilterStars extends StatelessWidget {
  ScreenFilterStars({Key? key, this.theUser}) : super(key: key);
  final User? theUser;

  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final CustomeStringFunctions customeStringFunctions =
      CustomeStringFunctions();
  final DateTimeOptimizer dateTimeOptimizer = DateTimeOptimizer();

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.grey.shade400,
      endDrawer: SafeArea(
        child: EndDrawer(theUser: theUser),
      ),
      appBar: AppBar(
        // backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        leading: functionArrowbackIconButton(context),
        title: customeText(theData: "Stars"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: serviceFirestore.firestoreInstance
                .collection("users")
                .doc(theUser!.uid)
                .collection("favAndStars")
                .doc("starfiles")
                .collection("files")
                .orderBy("fileFavedOrStaredAt", descending: true)
                .snapshots(),
            builder: (context, snapshotFiles) {
              if (snapshotFiles.connectionState == ConnectionState.waiting) {
                return loadingIndicator();
              } else if (snapshotFiles.hasError) {
                return customeText(theData: "err ${snapshotFiles.error}");
              } else if (snapshotFiles.data == null || !snapshotFiles.hasData) {
                return customeText(
                    theData: 'snapshotFiles is empty(StreamBuilder)');
              }

              // // snapshotFiles.data!.docs.first;
              // debugPrint('44444files');
              // debugPrint(snapshotFiles.data!.docs.length.toString());
              // debugPrint(snapshotFiles.data.toString());

              snapshotFiles.data?.docs;

              final int filesLength = snapshotFiles.data!.docs.length;

              if (filesLength == 0) {
                return noItemFound(
                  theItemName: 'Stared Grasp',
                  theScreenHeight: screenHeight,
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 80),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshotFiles.data!.docs.length,
                  itemBuilder: (context, theRecordStar) {
                    final QueryDocumentSnapshot<Map<String, dynamic>>
                        theRecordStarItem =
                        snapshotFiles.data!.docs[theRecordStar];

                    final String theRecordStarItemFileSubjectName =
                        theRecordStarItem.data()['fileSubjectName'];

                    final theRecordStarItemFileName =
                        theRecordStarItem.data()["fileName"];
                    // ignore: unused_local_variable
                    final theRecordStarFileCreatedAt =
                        theRecordStarItem.data()["fileCreatedAt"];

                    // ignore: unused_local_variable
                    final String theRecordStarItemFileNameAbbreviated =
                        customeStringFunctions.customeSubString(
                      theString: theRecordStarItemFileName,
                      theResultLengthLimit: 8,
                    );

                    // if (!listOfCurrentFilesName
                    //     .contains(theRecordStarItemFileName)) {
                    //   listOfCurrentFilesNameFunction()
                    //       .add(theRecordStarItemFileName);
                    // } // fix here dynamic

                    // final theRecordStarFileCreatedAtConverted =
                    //     DateTime.fromMillisecondsSinceEpoch(
                    //         theRecordStarFileCreatedAt); // // fix here dynamic

                    // var theRecordStarFileCreatedAtVarListBoilerPlate = {
                    //   'time': dateTimeOptimizer.dateTimeTwelveHourFormater(
                    //       hourNumber: theRecordStarFileCreatedAtConverted.hour,
                    //       minuteNumber: theRecordStarFileCreatedAtConverted.minute),
                    //   'date':
                    //       '${dateTimeOptimizer.dateTimeNumberToMonthName(monthNumber: theRecordStarFileCreatedAtConverted.month)}.${theRecordStarFileCreatedAtConverted.day}, ${theRecordStarFileCreatedAtConverted.year}',
                    // }; // fix here dynamic
                    return Column(
                      children: [
                        theRecordStar == 0
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
                                //     customeText( theData:
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
                          isSubtitleDate: true,
                          theUser: theUser!,
                          theFileName: theRecordStarItemFileName,
                          theFileSubjectName: theRecordStarItemFileSubjectName,
                          subjectFileRecordId: "${theRecordStar + 1}",
                          subjectFileRecordName: theRecordStarItemFileName,
                          subjectFileRecordTime: "subject",
                          // theRecordStarFileCreatedAtVarListBoilerPlate['time']
                          //     .toString(), // fix here dynamic
                          subjectFileRecordDate:
                              theRecordStarItemFileSubjectName,
                          // theRecordStarFileCreatedAtVarListBoilerPlate['date']
                          //     .toString(),
                          theTrailingOnPressed: () {
                            customeSnackbar(
                              theTitle: 'Grasp caution',
                              theMessage:
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
                            //     fileNameOld: theRecordStarItemFileNameAbbreviated,
                            //     controller: controllerEditGraspFileName,
                            //     theOnPressed: () {},
                            //   ),
                            // );
                          },
                          theOnLongPress: () async {
                            showAnimatedDialog(
                              barrierColor: Colors.black38,
                              barrierDismissible: true,
                              context: context,
                              animationType: DialogTransitionType.sizeFade,
                              curve: Curves.easeOut,
                              alignment: Alignment.bottomCenter,
                              duration: const Duration(milliseconds: 800),
                              builder: (_) => DialogUnfavUnstarGraspFiles(
                                theIsUnfavTrueUnstarFalse: false,
                                theName: theRecordStarItemFileNameAbbreviated,
                                theOnPressed: () async {
                                  await serviceFirestore
                                      .unfavUnstarGraspFile(
                                    user: theUser!,
                                    theFileName: theRecordStarItemFileName,
                                    isFileUnfavedTrueUnstaredFalse: false,
                                  )
                                      .then(
                                    (_) {
                                      Get.back();
                                      return customeSnackbar(
                                        theTitle: 'Grasp caution',
                                        theMessage:
                                            'The grasp "$theRecordStarItemFileNameAbbreviated" has unstared succesfully.',
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
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
