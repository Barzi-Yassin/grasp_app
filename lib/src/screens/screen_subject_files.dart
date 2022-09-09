import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subject_files/widget_subject_file_records.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenSubjectFiles extends StatefulWidget {
  const ScreenSubjectFiles({
    Key? key,
    required this.theUser,
    required this.theFileSubjectName,
  }) : super(key: key);

  final User theUser;
  final String theFileSubjectName;

  @override
  State<ScreenSubjectFiles> createState() => _ScreenSubjectFilesState();
}

class _ScreenSubjectFilesState extends State<ScreenSubjectFiles> {
  final ServiceFirestore serviceFirestore = ServiceFirestore();

  final TextEditingController controllerAddGraspFile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(
        child: EndDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        leading: functionArrowbackIconButton(context),
        // title: const Text('Programming Fund'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                debugPrint('theFileSubjectName::${widget.theFileSubjectName}');
              },
              child: const FaIcon(
                FontAwesomeIcons.solidFolderOpen,
                size: 20,
              ),
            ),
            // Text('  $subjectRecordNamenn'),
            Text(widget.theFileSubjectName
                // '  ${datalistSubject[widget.theRecordFromSubject]["subject_name"]}'
                ),
                
          ],
        ),
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
            // /users/jlMLgST8YtTHahuoRc5BKX1miaX2/subjects/subj1/files
            // /users/jlMLgST8YtTHahuoRc5BKX1miaX2/subjects/subj1/files
            stream: serviceFirestore.firestoreInstance
                .collection("users")
                .doc(widget.theUser.uid)
                .collection("subjects")
                .doc(widget.theFileSubjectName)
                // .doc("sub1")
                .collection("files")
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
              debugPrint('44444');
              debugPrint(snapshot.data!.docs.length.toString());
              debugPrint(snapshot.data.toString());

              snapshot.data?.docs;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                scrollDirection: Axis.vertical,
                // itemCount: datalistSubjectFiles.length,
                itemCount: snapshot.data!.docs.length,
                // int.parse(datalistSubject[widget.theRecordFromSubject]
                //         ["subject_items_number"]
                //     .toString()),
                itemBuilder: (context, theRecord) {
                  final QueryDocumentSnapshot<Map<String, dynamic>>
                      theRecordItem = snapshot.data!.docs[theRecord];

                  // final DateTime dateTime = DateTime.parse(theRecordItem
                  //     .data()["fileCreatedAt"]
                  //     .toDate()
                  //     .toString());

                  return WidgetSubjectFileRecords(
                    subjectFileRecordId: "${theRecord + 1}",
                    subjectFileRecordName: theRecordItem.data()["fileName"],
                    subjectFileRecordTime:
                        theRecordItem.data()["fileCreatedAt"].toString(),
                    subjectFileRecordDate:
                        theRecordItem.data()["fileCreatedAt"].toString(),
                    // subjectFileRecordName: datalistSubjectFiles[theRecord]["subject_file_name"].toString(),
                    // subjectFileRecordTime: datalistSubjectFiles[theRecord]["subject_file_time"].toString(),
                    // subjectFileRecordDate: datalistSubjectFiles[theRecord]["subject_file_date"].toString(),
                  );
                },
              );
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
            theOnPressed: () {
              if (controllerAddGraspFile.text.isNotEmpty) {
                serviceFirestore
                    .createFile(
                      user: widget.theUser,
                      theFileSubjectName: widget.theFileSubjectName,
                      theFileName: controllerAddGraspFile.text,
                      theFileId: 1.toString(),
                      theIsFileFaved: false,
                      theIsFileStared: true,
                      theIsFileUpdated: false,
                    )
                    .then((_) => Get.back());
              } else {
                Get.back();
                Get.snackbar('error', 'Give a name to the new grasps!');
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
