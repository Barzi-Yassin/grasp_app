import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/data/datalist_subject_files.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_add.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/reusable_codes/widgets/subject_files/widget_subject_file_records.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenSubjectFiles extends StatefulWidget {
  const ScreenSubjectFiles({
    Key? key,
    required this.theRecordFromSubject,
  }) : super(key: key);

  final int theRecordFromSubject;

  @override
  State<ScreenSubjectFiles> createState() => _ScreenSubjectFilesState();
}

class _ScreenSubjectFilesState extends State<ScreenSubjectFiles> {
  final TextEditingController controllerAddGraspFile = TextEditingController();
  final ServiceFirestore serviceFirestore = ServiceFirestore();

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
            const FaIcon(
              FontAwesomeIcons.solidFolderOpen,
              size: 20,
            ),
            // Text('  $subjectRecordNamenn'),
            Text(
                '  ${datalistSubject[widget.theRecordFromSubject]["subject_name"]}'),
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
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          scrollDirection: Axis.vertical,
          // itemCount: datalistSubjectFiles.length,
          itemCount: int.parse(datalistSubject[widget.theRecordFromSubject]
                  ["subject_items_number"]
              .toString()),
          itemBuilder: (context, theRecord) {
            return WidgetSubjectFileRecords(
              subjectFileRecordId: "${theRecord + 1}",
              subjectFileRecordName: datalistSubjectFiles[theRecord]
                      ["subject_file_name"]
                  .toString(),
              subjectFileRecordTime: datalistSubjectFiles[theRecord]
                      ["subject_file_time"]
                  .toString(),
              subjectFileRecordDate: datalistSubjectFiles[theRecord]
                      ["subject_file_date"]
                  .toString(),
            );
          },
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
            theOnPressed: () {},
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
