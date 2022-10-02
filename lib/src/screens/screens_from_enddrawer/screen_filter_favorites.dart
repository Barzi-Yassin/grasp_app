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

class ScreenFilterFavorites extends StatelessWidget {
  ScreenFilterFavorites({Key? key, this.theUser}) : super(key: key);
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
        title: customeText(theData: 'Favorites'), // change to custome widgets
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
                .doc("favfiles")
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
                  theItemName: 'Faved Grasp',
                  theScreenHeight: screenHeight,
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 80),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshotFiles.data!.docs.length,
                  itemBuilder: (context, theRecordFav) {
                    final QueryDocumentSnapshot<Map<String, dynamic>>
                        theRecordFavItem =
                        snapshotFiles.data!.docs[theRecordFav];

                    final String theRecordFavItemFileSubjectName =
                        theRecordFavItem.data()['fileSubjectName'];

                    final theRecordFavItemFileName =
                        theRecordFavItem.data()["fileName"];
                    // ignore: unused_local_variable
                    final theRecordFavFileCreatedAt =
                        theRecordFavItem.data()["fileCreatedAt"];

                    // ignore: unused_local_variable
                    final String theRecordFavItemFileNameAbbreviated =
                        customeStringFunctions.customeSubString(
                      theString: theRecordFavItemFileName,
                      theResultLengthLimit: 8,
                    );

                    // if (!listOfCurrentFilesName
                    //     .contains(theRecordFavItemFileName)) {
                    //   listOfCurrentFilesNameFunction()
                    //       .add(theRecordFavItemFileName);
                    // } // fix here dynamic

                    // final theRecordFavFileCreatedAtConverted =
                    //     DateTime.fromMillisecondsSinceEpoch(
                    //         theRecordFavFileCreatedAt); // // fix here dynamic

                    // var theRecordFavFileCreatedAtVarListBoilerPlate = {
                    //   'time': dateTimeOptimizer.dateTimeTwelveHourFormater(
                    //       hourNumber: theRecordFavFileCreatedAtConverted.hour,
                    //       minuteNumber: theRecordFavFileCreatedAtConverted.minute),
                    //   'date':
                    //       '${dateTimeOptimizer.dateTimeNumberToMonthName(monthNumber: theRecordFavFileCreatedAtConverted.month)}.${theRecordFavFileCreatedAtConverted.day}, ${theRecordFavFileCreatedAtConverted.year}',
                    // }; // fix here dynamic
                    return Column(
                      children: [
                        theRecordFav == 0
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
                          theFileName: theRecordFavItemFileName,
                          theFileSubjectName: theRecordFavItemFileSubjectName,
                          subjectFileRecordId: "${theRecordFav + 1}",
                          subjectFileRecordName: theRecordFavItemFileName,
                          subjectFileRecordTime: "subject",
                          // theRecordFavFileCreatedAtVarListBoilerPlate['time']
                          //     .toString(), // fix here dynamic
                          subjectFileRecordDate:
                              theRecordFavItemFileSubjectName,
                          // theRecordFavFileCreatedAtVarListBoilerPlate['date']
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
                            //     fileNameOld: theRecordFavItemFileNameAbbreviated,
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
                                theIsUnfavTrueUnstarFalse: true,
                                theName: theRecordFavItemFileNameAbbreviated,
                                theOnPressed: () async {
                                  await serviceFirestore
                                      .unfavUnstarGraspFile(
                                    user: theUser!,
                                    theFileName: theRecordFavItemFileName,
                                    isFileUnfavedTrueUnstaredFalse: true,
                                  )
                                      .then(
                                    (_) {
                                      Get.back();
                                      return customeSnackbar(
                                        theTitle: 'Grasp caution',
                                        theMessage:
                                            'The grasp "$theRecordFavItemFileNameAbbreviated" has unfaved succesfully.',
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },

                          // theOnLongPress: () {},
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
                          //       theName: theRecordFavItemFileName,
                          //       theOnPressed: () async {
                          //         await serviceFirestore
                          //             .deleteFile(
                          //           user: widget.theUser,
                          //           theFileSubjectName:
                          //               widget.theFileSubjectName,
                          //           theFileName: theRecordFavItemFileName,
                          //         )
                          //             .then(
                          //           (value) {
                          //             Get.back();
                          //             listOfCurrentFilesNameFunction()
                          //                 .remove(theRecordFavItemFileName);
                          //             serviceFirestore.updateSubject(
                          //                 user: widget.theUser,
                          //                 theSubjectName:
                          //                     widget.theFileSubjectName,
                          //                 theSubjectItemsNumber:
                          //                     listOfCurrentFilesName.length
                          //                         .toString());

                          //             Get.snackbar('Grasp caution',
                          //                 'The Grasp "$theRecordFavItemFileNameAbbreviated" has been deleted successfully.');
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
