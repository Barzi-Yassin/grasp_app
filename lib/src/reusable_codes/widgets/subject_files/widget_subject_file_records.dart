import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetSubjectFileRecords extends StatelessWidget {
  const WidgetSubjectFileRecords({
    Key? key,
    required this.subjectFileRecordId,
    required this.subjectFileRecordName,
    required this.subjectFileRecordTime,
    required this.subjectFileRecordDate,
  }) : super(key: key);

  final String subjectFileRecordId;
  final String subjectFileRecordName;
  final String subjectFileRecordTime;
  final String subjectFileRecordDate;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 55.0,
        margin: const EdgeInsets.only(bottom: 10.0, left: 6.0, right: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: Colors.white.withOpacity(0.9),
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
          subtitle: Text('$subjectFileRecordTime am • $subjectFileRecordDate'),
          trailing: IconButton(
            onPressed: () {
              debugPrint('trash clicked');
            },
            icon: const FaIcon(FontAwesomeIcons.trashCan),
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }
}
