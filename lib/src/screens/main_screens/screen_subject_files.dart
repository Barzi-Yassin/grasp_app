import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_delete.dart';
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

  final TextEditingController controllerAddGraspFile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      endDrawer: SafeArea(
        child: EndDrawer(),
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
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Expanded(
            //       child: Divider(
            //         thickness: 1,
            //         endIndent: 10,
            //       ),
            //     ),
            //     Text(
            //       '${widget.theFileSubjectName}  4',
            //       style:
            //           const TextStyle(color: Color.fromARGB(255, 126, 50, 50)),
            //     ),
            //     const Expanded(
            //       child: Divider(
            //         thickness: 1,
            //         indent: 10,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 0),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: serviceFirestore.firestoreInstance
                      .collection("users2")
                      .doc(widget.theUser.uid)
                      .collection("subjects")
                      .doc(widget.theFileSubjectName)
                      .collection("files")
                      .orderBy("fileCreatedAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshotFiles) {
                    if (snapshotFiles.connectionState ==
                        ConnectionState.waiting) {
                      return loadingIndicator();
                    } else if (snapshotFiles.hasError) {
                      return Text("err ${snapshotFiles.error}");
                    } else if (snapshotFiles.data == null ||
                        !snapshotFiles.hasData) {
                      return const Text(
                          'snapshotFiles is empty(StreamBuilder)');
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
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshotFiles.data!.docs.length,
                        itemBuilder: (context, theRecord) {
                          final QueryDocumentSnapshot<Map<String, dynamic>>
                              theRecordItem =
                              snapshotFiles.data!.docs[theRecord];
                          final theRecordFileName =
                              theRecordItem.data()["fileName"];
                          final theRecordFileCreatedAt =
                              theRecordItem.data()["fileCreatedAt"];

                          if (!listOfCurrentFilesName
                              .contains(theRecordFileName)) {
                            listOfCurrentFilesNameFunction()
                                .add(theRecordFileName);
                          }
                          final theRecordFileCreatedAtConverted =
                              DateTime.fromMillisecondsSinceEpoch(
                                  theRecordFileCreatedAt);

                          // var theRecordFileCreatedAtVarList = {
                          //   'year': theRecordFileCreatedAtConverted.year.toString(),
                          //   'month': theRecordFileCreatedAtConverted.month.toString(),
                          //   'day': theRecordFileCreatedAtConverted.day.toString(),
                          //   'hour': theRecordFileCreatedAtConverted.hour.toString(),
                          //   'minutes':
                          //       theRecordFileCreatedAtConverted.minute.toString(),
                          //   'seconds':
                          //       theRecordFileCreatedAtConverted.second.toString(),
                          //   'millisecond': theRecordFileCreatedAtConverted.millisecond
                          //       .toString(),
                          // };

                          // debugPrint(
                          //     'hello $theRecordFileName :: ${theRecordFileCreatedAtVarList['year']}');
                          // debugPrint(
                          //     'hello $theRecordFileName :: ${theRecordFileCreatedAtVarList['month']}');
                          // debugPrint(
                          //     'hello $theRecordFileName :: ${theRecordFileCreatedAtVarList['day']}');
                          // debugPrint(
                          //     'hello $theRecordFileName :: ${theRecordFileCreatedAtVarList['hour']}');
                          // debugPrint(
                          //     'hello $theRecordFileName :: ${theRecordFileCreatedAtVarList['minutes']}');
                          // debugPrint(
                          //     'hello $theRecordFileName :: ${theRecordFileCreatedAtVarList['seconds']}');
                          // debugPrint(
                          //     'hello $theRecordFileName :: ${theRecordFileCreatedAtVarList['millisecond']}');

                          // final String year =
                          //     theRecordFileCreatedAtConverted.year.toString();
                          // final String month =
                          //     theRecordFileCreatedAtConverted.month.toString();
                          // final String day =
                          //     theRecordFileCreatedAtConverted.day.toString();
                          // final String hour =
                          //     theRecordFileCreatedAtConverted.hour.toString();
                          // final String minute =
                          //     theRecordFileCreatedAtConverted.minute.toString();

                          // debugPrint(
                          //     '$theRecordFileName created at:: $theRecordFileCreatedAtConverted');
                          // debugPrint('$theRecordFileName year is:: $year');
                          // debugPrint('$theRecordFileName month is:: $month');
                          // debugPrint('$theRecordFileName day is:: $day');
                          // debugPrint('$theRecordFileName hour is:: $hour');
                          // debugPrint('$theRecordFileName minute is:: $minute');

                          var theRecordFileCreatedAtVarListBoilerPlate = {
                            'time':
                                dateTimeOptimizer.dateTimeTwelveHourFormater(
                                    hourNumber:
                                        theRecordFileCreatedAtConverted.hour,
                                    minuteNumber:
                                        theRecordFileCreatedAtConverted.minute),
                            // '${theRecordFileCreatedAtConverted.hour}:${theRecordFileCreatedAtConverted.minute}',
                            'date':
                                '${dateTimeOptimizer.dateTimeNumberToMonthName(monthNumber: theRecordFileCreatedAtConverted.month)}.${theRecordFileCreatedAtConverted.day}, ${theRecordFileCreatedAtConverted.year}',
                            // 'date': theRecordFileCreatedAtConverted.month.toString(),
                          };
                          // debugPrint(
                          //     'e7m:: ${theRecordFileCreatedAtVarListBoilerPlate['time']}');
                          // debugPrint(
                          //     'e7m:: ${theRecordFileCreatedAtVarListBoilerPlate['date']}');

                          return Column(
                            children: [
                              WidgetSubjectFileRecords(
                                theUser: widget.theUser,
                                theFileName: theRecordFileName,
                                theFileSubjectName: widget.theFileSubjectName,
                                subjectFileRecordId: "${theRecord + 1}",
                                subjectFileRecordName: theRecordFileName,
                                subjectFileRecordTime:
                                    theRecordFileCreatedAtVarListBoilerPlate[
                                            'time']
                                        .toString(),
                                subjectFileRecordDate:
                                    theRecordFileCreatedAtVarListBoilerPlate[
                                            'date']
                                        .toString(),
                                theTrailingOnPressed: () async {
                                  showAnimatedDialog(
                                    barrierColor: Colors.black38,
                                    barrierDismissible: true,
                                    context: context,
                                    animationType:
                                        DialogTransitionType.sizeFade,
                                    curve: Curves.easeOut,
                                    alignment: Alignment.bottomCenter,
                                    duration: const Duration(milliseconds: 800),
                                    builder: (_) => DialogDelete(
                                      theTitle: "Grasp",
                                      theName: theRecordFileName,
                                      theOnPressed: () async {
                                        await serviceFirestore
                                            .deleteFile(
                                          user: widget.theUser,
                                          theFileSubjectName:
                                              widget.theFileSubjectName,
                                          theFileName: theRecordFileName,
                                        )
                                            .then(
                                          (value) {
                                            Get.back();
                                            listOfCurrentFilesNameFunction()
                                                .remove(theRecordFileName);
                                            serviceFirestore.updateSubject(
                                                user: widget.theUser,
                                                theSubjectName:
                                                    widget.theFileSubjectName,
                                                theSubjectItemsNumber:
                                                    listOfCurrentFilesName
                                                        .length
                                                        .toString());

                                            Get.snackbar('Grasp caution',
                                                'The Grasp "$theRecordFileName" has been deleted successfully.');
                                            debugPrint(
                                                'jjjjjjjj delete :: ${listOfCurrentFilesName.length}');
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              theRecord == (snapshotFiles.data!.docs.length - 1)
                                  ? SizedBox(
                                    height: 50,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                color: Color.fromARGB(
                                                    255, 126, 50, 50)),
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
                            ],
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
                  Get.snackbar(
                      'Grasp caution', 'The grasp name is already exist!');
                }
              } else {
                // Get.back();
                Get.snackbar('Grasp caution', 'Give a name to the new grasps!');
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