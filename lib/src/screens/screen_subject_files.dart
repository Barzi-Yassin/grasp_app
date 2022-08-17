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
            barrierColor: Colors.cyan.withOpacity(0.3),
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 5,
                actionsOverflowButtonSpacing: 0,
                // shape: ShapeBorder.lerp(ShapeBorder, b, t),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 2.5),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                // backgroundColor: Colors.white,
                // backgroundColor: Color.lerp(Colors.white, Colors.black, 0.1),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: Row(
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
                content: TextFormField(
                  decoration: const InputDecoration(
                    // alignLabelWithHint: true,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
                    labelText: 'Grasp name',
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color.lerp(Colors.grey, Colors.red, 0.2))),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancle'),
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
            alignment: Alignment.topCenter,
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
