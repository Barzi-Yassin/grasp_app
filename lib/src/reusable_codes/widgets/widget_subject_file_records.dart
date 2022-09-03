import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetSubjectFileRecords extends StatelessWidget {
  const WidgetSubjectFileRecords({
    Key? key,
    // required this.subjectRecordName,
    required this.subjectFileRecordId,
    required this.subjectFileRecordName,
    required this.subjectFileRecordTime,
    required this.subjectFileRecordDate,
    // required this.subjectRecordFileItemsNumber,
  }) : super(key: key);

  // final String subjectRecordName;
  final String subjectFileRecordId;
  final String subjectFileRecordName;
  final String subjectFileRecordTime;
  final String subjectFileRecordDate;
  // final int subjectRecordFileItemsNumber;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 55.0,
        margin: const EdgeInsets.only(bottom: 10.0, left: 6.0, right: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 06.0,
            ),
          ],
        ),
        child: ListTile(
          dense: true,
          iconColor: const Color.fromARGB(255, 0, 171, 193),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4),
            child: Text(subjectFileRecordId),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Text(
              subjectFileRecordName,
              style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
          subtitle: Text('$subjectFileRecordTime am - $subjectFileRecordDate'),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    debugPrint('archive clicked');
                  },
                  icon: const Icon(Icons.archive_outlined)),
              // const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  debugPrint('trash clicked');
                },
                icon: const FaIcon(FontAwesomeIcons.trashCan),
                color: Colors.cyan,
              ),
              // const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
