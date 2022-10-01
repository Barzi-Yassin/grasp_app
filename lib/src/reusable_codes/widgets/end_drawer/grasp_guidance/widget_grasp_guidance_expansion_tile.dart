import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class WidgetGraspGuidanceExpansionTile extends StatefulWidget {
  const WidgetGraspGuidanceExpansionTile({
    super.key,
    required this.graspGuidanceId,
    required this.graspGuidanceTitle,
    required this.graspGuidanceDescription,
  });
  final String graspGuidanceId;
  final String graspGuidanceTitle;
  final String graspGuidanceDescription;

  @override
  State<WidgetGraspGuidanceExpansionTile> createState() =>
      Widget_GraspGuidanceExpansionTileState();
}

class Widget_GraspGuidanceExpansionTileState
    extends State<WidgetGraspGuidanceExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 55.0,
      margin: const EdgeInsets.only(bottom: 10.0, left: 12.0, right: 12.0),
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
      child: ExpansionTile(
        // backgroundColor: Colors.green,


        tilePadding: EdgeInsets.only(left: 15, right: 15),
        childrenPadding: const EdgeInsets.only(left: 20, right: 20),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        // iconColor: Colors.cyan.shade800,
        // textColor: Colors.white.withOpacity(0.8),
        textColor: Colors.black,
        // backgroundColor: Colors.cyan.shade50,
        // collapsedIconColor: Colors.black,
        // collapsedTextColor: Colors.black,
        title: Row(
          children: [
            Container(
              width: 25,
              // color: Colors.red,
              child: customeText(
                theData: widget.graspGuidanceId,
                theFontSize: 18,
                theTextAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 10,
              child: customeText(theData:  _customTileExpanded  ? "" : "-"),
            ),
            customeText(
              theData:'${widget.graspGuidanceTitle}',
              theFontFamily: "MavenPro",
              theFontWeight: FontWeight.w500,
              theFontSize: 17,
              theLetterSpacing: 0.5,
              // theTextAlign: TextAlign.center,
            ),
          ],
        ),
        trailing: customeIcon(
          theIcon:
              _customTileExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        ),
        children: <Widget>[
          customeText(
            theData: widget.graspGuidanceDescription,
            theFontSize: 015,
            // theFontWeight: FontWeight.w400,
            theLetterSpacing: 0.4,
            theColor: Colors.black,
            theFontFamily: "MavenPro",
            theTextAlign: TextAlign.justify,
            // theMaxLines: 1,
          ),
          const SizedBox(
            height: 15,
          )
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _customTileExpanded = expanded);
        },
      ),
    );
  }
}
