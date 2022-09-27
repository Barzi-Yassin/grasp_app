import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class DialogUnfavUnstarGraspFiles extends StatefulWidget {
  const DialogUnfavUnstarGraspFiles({
    super.key,
    required this.theIsUnfavTrueUnstarFalse,
    required this.theName,
    this.theOnPressed,
  });

  final bool theIsUnfavTrueUnstarFalse;
  final String theName;
  final theOnPressed; // TODO: fix it's error

  @override
  State<DialogUnfavUnstarGraspFiles> createState() =>
      _DialogUnfavUnstarGraspFilesState();
}

class _DialogUnfavUnstarGraspFilesState
    extends State<DialogUnfavUnstarGraspFiles> {
  @override
  Widget build(BuildContext context) {
    String generateTitle =
        widget.theIsUnfavTrueUnstarFalse ? "Unfav" : "Unstar";
    return AlertDialog(
      // insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      insetPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      // theTitlePadding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      elevation: 5,
      actionsOverflowButtonSpacing: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.cyan,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 15.0),
        decoration: BoxDecoration(
          gradient: dialogHeaderGradient(),
          borderRadius: BorderRadius.circular(15),
        ), //

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Divider(
                thickness: 1,
                endIndent: 10,
              ),
            ),
            customeText(
              theData: '$generateTitle Grasp',
              theColor: Color.fromARGB(255, 126, 50, 50),
            ),
            const Expanded(
              child: Divider(
                thickness: 1,
                indent: 10,
              ),
            ),
          ],
        ),
      ),
      content: customeText(
        theData: '$generateTitle grasp "${widget.theName}" !',
        theTextAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.all(
              //   Color.lerp(Colors.grey, Colors.red, 0.2),
              // ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.cyan))),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: customeText(
            theData: "Cancle",
            theColor: Colors.cyan,
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.cyan),
          ),
          onPressed: widget.theOnPressed,
          child: customeText(
              theData: generateTitle,
              theColor: Colors.white,
              theLetterSpacing: 0.5),
        ),
      ],
    );
  }
}
