import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_main_boilerplate.dart';

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
    return DialogMainBoilerplate(
      theTitle: '$generateTitle Grasp',
      theWidgetContent: customeText(
        theData: '$generateTitle grasp "${widget.theName}" !',
        theTextAlign: TextAlign.center,
      ),
      theIsButtonElevatedWithIcon: false,
      theButtonLabel: generateTitle,
      theOnPressed: widget.theOnPressed,
    );
  }
}
