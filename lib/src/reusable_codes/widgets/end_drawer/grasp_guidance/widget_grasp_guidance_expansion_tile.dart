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
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 30, right: 15),
      childrenPadding: const EdgeInsets.only(left: 30, right: 20),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      iconColor: Colors.cyan.shade800,
      // textColor: Colors.white.withOpacity(0.8),
      textColor: Colors.cyan.shade800,
      // backgroundColor: Colors.cyan.shade50,
      collapsedIconColor: Colors.white,
      collapsedTextColor: Colors.white,
      title: customeText(
          theData: '${widget.graspGuidanceId}. ${widget.graspGuidanceTitle}',
          theFontFamily: "MavenPro",
          theFontWeight: FontWeight.w600,
          theFontSize: 17,
          theLetterSpacing: 0.5),
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
          theColor: Colors.black54,
          theFontFamily: "MavenPro",
          // theMaxLines: 1,
        ),
        const SizedBox(
          height: 15,
        )
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded);
      },
    );
  }
}
