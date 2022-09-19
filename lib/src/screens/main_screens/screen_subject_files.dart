import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_delete.dart';
// ignore: unused_import
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_edit.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subject_files/widget_subject_file_records.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenSubjectFiles extends StatefulWidget {
  const ScreenSubjectFiles({
    Key? key,
    required this.theUser,
    required this.theFileSubjectName,
    required this.theFileSubjectCreatedAt,
    required this.theFileSubjectUpdatedAt,
  }) : super(key: key);

  final User theUser;
  final String theFileSubjectName;
  final String theFileSubjectCreatedAt;
  final String theFileSubjectUpdatedAt;

  @override
  State<ScreenSubjectFiles> createState() => _ScreenSubjectFilesState();
}

class _ScreenSubjectFilesState extends State<ScreenSubjectFiles> {
  // start listOfCurrentFilesName of the current subject names
  List<String> listOfCurrentFilesName = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listOfCurrentFilesName = <String>[];
  }

  List<String> listOfCurrentFilesNameFunction() {
    int len = listOfCurrentFilesName.length;
    debugPrint('There are ${len + 1} file(s) in the listOfCurrentFilesName');
    return listOfCurrentFilesName;
  }
  // end listOfCurrentFilesName of the current subject names

  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final DateTimeOptimizer dateTimeOptimizer = DateTimeOptimizer();
  final CustomeStringFunctions customeStringFunctions =
      CustomeStringFunctions();

  final TextEditingController controllerAddGraspFile = TextEditingController();
  final TextEditingController controllerEditGraspFileName =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      endDrawer: SafeArea(
        child: EndDrawer(theUser: widget.theUser),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        // centerTitle: true,
        leading: functionArrowbackIconButton(context),
        title: appbarTitleFolderIconAndName(
            theFolderaName: widget.theFileSubjectName),
        // actions: [IconButton(onPressed: () {
        //   // Navigator.pop(context);
        //   // return EndDrawer();
        //   // Navigator.pushNamed(context, RouteScreens.routeEndDrawer);
        // }, icon: Icon(Icons.help_outline))],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: serviceFirestore.firestoreInstance
                .collection("users")
                .doc(widget.theUser.uid)
                .collection("subjects")
                .doc(widget.theFileSubjectName)
                .collection("files")
                .orderBy("fileCreatedAt", descending: true)
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
                return noItemFound(
                  theItemName: 'Grasp',
                  theScreenHeight: screenHeight,
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 80),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshotFiles.data!.docs.length,
                  itemBuilder: (context, theRecord) {
                    final QueryDocumentSnapshot<Map<String, dynamic>>
                        theRecordItem = snapshotFiles.data!.docs[theRecord];
                    final theRecordItemFileName =
                        theRecordItem.data()["fileName"];
                    final theRecordFileCreatedAt =
                        theRecordItem.data()["fileCreatedAt"];

                    final String theRecordItemFileNameAbbreviated =
                        customeStringFunctions.customeSubString(
                            theString: theRecordItemFileName,
                            theResultLengthLimit: 5);

                    if (!listOfCurrentFilesName
                        .contains(theRecordItemFileName)) {
                      listOfCurrentFilesNameFunction()
                          .add(theRecordItemFileName);
                    }
                    final theRecordFileCreatedAtConverted =
                        DateTime.fromMillisecondsSinceEpoch(
                            theRecordFileCreatedAt);

                    var theRecordFileCreatedAtVarListBoilerPlate = {
                      'time': dateTimeOptimizer.dateTimeTwelveHourFormater(
                          hourNumber: theRecordFileCreatedAtConverted.hour,
                          minuteNumber: theRecordFileCreatedAtConverted.minute),
                      'date':
                          '${dateTimeOptimizer.dateTimeNumberToMonthName(monthNumber: theRecordFileCreatedAtConverted.month)}.${theRecordFileCreatedAtConverted.day}, ${theRecordFileCreatedAtConverted.year}',
                    };
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
                                    Text(
                                      widget.theFileSubjectCreatedAt,
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
                        WidgetSubjectFileRecords(
                          theUser: widget.theUser,
                          theFileName: theRecordItemFileName,
                          theFileSubjectName: widget.theFileSubjectName,
                          subjectFileRecordId: "${theRecord + 1}",
                          subjectFileRecordName: theRecordItemFileName,
                          subjectFileRecordTime:
                              theRecordFileCreatedAtVarListBoilerPlate['time']
                                  .toString(),
                          subjectFileRecordDate:
                              theRecordFileCreatedAtVarListBoilerPlate['date']
                                  .toString(),
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
                            //     fileNameOld: theRecordItemFileNameAbbreviated,
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
                              builder: (_) => DialogDelete(
                                theTitle: "Grasp",
                                theName: theRecordItemFileName,
                                theOnPressed: () async {
                                  await serviceFirestore
                                      .deleteFile(
                                    user: widget.theUser,
                                    theFileSubjectName:
                                        widget.theFileSubjectName,
                                    theFileName: theRecordItemFileName,
                                  )
                                      .then(
                                    (value) {
                                      Get.back();
                                      listOfCurrentFilesNameFunction()
                                          .remove(theRecordItemFileName);
                                      serviceFirestore.updateSubject(
                                          user: widget.theUser,
                                          theSubjectName:
                                              widget.theFileSubjectName,
                                          theSubjectItemsNumber:
                                              listOfCurrentFilesName.length
                                                  .toString());

                                      customeSnackbar(
                                        theTitle: 'Grasp caution',
                                        theMessage:
                                            'The Grasp "$theRecordItemFileNameAbbreviated" has been deleted successfully.',
                                      );
                                      debugPrint(
                                          'jjjjjjjj delete :: ${listOfCurrentFilesName.length}');
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAnimatedDialog(
          barrierColor: Colors.black38,
          barrierDismissible: true,
          context: context,
          builder: (_) => DialogAdd(
            controller: controllerAddGraspFile,
            title: 'Grasp',
            theOnPressed: () async {
              debugPrint(listOfCurrentFilesName
                  .contains(controllerAddGraspFile.text)
                  .toString());

              if (controllerAddGraspFile.text.isNotEmpty) {
                if (!listOfCurrentFilesName
                    .contains(controllerAddGraspFile.text)) {
                  await serviceFirestore
                      .createFile(
                    user: widget.theUser,
                    theFileSubjectName: widget.theFileSubjectName,
                    theFileName: controllerAddGraspFile.text,
                    theIsFileFaved: false,
                    theIsFileStared: true,
                    theIsFileUpdated: false,
                  )
                      .then(
                    (_) {
                      serviceFirestore.updateSubject(
                          user: widget.theUser,
                          theSubjectName: widget.theFileSubjectName,
                          theSubjectItemsNumber:
                              listOfCurrentFilesName.length.toString());
                      debugPrint(
                          'jjjjjjjj :: ${listOfCurrentFilesName.length}');
                      Get.back();
                    },
                  );
                } else {
                  debugPrint('the grasp name is already exist !!!');
                  customeSnackbar(
                    theTitle: 'Grasp caution',
                    theMessage: 'The grasp name is already exist!',
                  );
                }
              } else {
                // Get.back();
                customeSnackbar(
                  theTitle: 'Grasp caution',
                  theMessage: 'Give a name to the new grasps!',
                );
              }
            },
          ),
          animationType: DialogTransitionType.sizeFade,
          curve: Curves.easeOut,
          alignment: Alignment.bottomCenter,
          duration: const Duration(milliseconds: 800),
        ),
        backgroundColor: Colors.cyan.shade400,
        elevation: 10,
        child: const FaIcon(
          FontAwesomeIcons.fileCirclePlus,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}


/*

f2 created at:: 2022-09-10 06:34:04.933 :: 1662780844933
f3 created at:: 2022-09-10 06:42:30.413 :: 1662781350413
f4 created at:: 2022-09-10 06:45:18.378 :: 1662781518378

*/