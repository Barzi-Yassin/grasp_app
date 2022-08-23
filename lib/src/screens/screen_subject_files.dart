import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/data/datalist_subject_files.dart';
import 'package:grasp_app/src/functions/functions.dart';
import 'package:grasp_app/src/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/widgets/widget_subject_file_records.dart';

class ScreenSubjectFiles extends StatelessWidget {
  const ScreenSubjectFiles({
    Key? key,
    required this.theRecordFromSubject,
  }) : super(key: key);

  final int theRecordFromSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SafeArea(
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
            Text('  ${datalistSubject[theRecordFromSubject]["subject_name"]}'),
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
          itemCount: int.parse(datalistSubject[theRecordFromSubject]
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
        onPressed: () {
          showAnimatedDialog(
            barrierColor: Colors.black38,
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                insetPadding: EdgeInsets.zero,
                titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                // titlePadding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
                contentPadding:
                    const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
                actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                elevation: 5,
                actionsOverflowButtonSpacing: 0,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    // color: Colors.lightBlue.shade200,
                    color: Colors.cyan,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                backgroundColor: Colors.white,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: Container(
                  padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 15.0),
                  decoration: BoxDecoration(
                      gradient: dialogHeaderGradient(),
                      
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))), //

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          endIndent: 10,
                        ),
                      ),
                      Text('New Grasp'),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          indent: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                content: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      // alignLabelWithHint: true,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      prefixIcon: Icon(Icons.close),
                      border: OutlineInputBorder(),
                      hintText: 'Grasp name',
                      // labelText: 'Grasp name2',
                      alignLabelWithHint: true),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(
                        //   Color.lerp(Colors.grey, Colors.red, 0.2),
                        // ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.cyan))),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
                      'Cancle',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.cyan)),
                    onPressed: () => Navigator.pop(context, 'Create'),
                    child: const Text('Create'),
                  ),
                ],
              );
            },
            animationType: DialogTransitionType.sizeFade,
            curve: Curves.easeOut,
            alignment: Alignment.bottomCenter,
            duration: const Duration(milliseconds: 800),
          );
        },
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
