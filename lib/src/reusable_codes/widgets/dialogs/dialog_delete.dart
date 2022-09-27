import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_main_boilerplate.dart';

class DialogDelete extends StatefulWidget {
  const DialogDelete({
    super.key,
    required this.theTitle,
    required this.theName,
    this.theOnPressed,
  });

  final String theTitle;
  final String theName;
  final theOnPressed; // TODO: fix it's error

  @override
  State<DialogDelete> createState() => _DialogDeleteState();
}

class _DialogDeleteState extends State<DialogDelete> {
  @override
  Widget build(BuildContext context) {
    return DialogMainBoilerplate(
      title: 'Delete ${widget.theTitle}',
      theWidgetContent: customeText(
          theData:
              'Delete ${widget.theTitle.toLowerCase()} "${widget.theName}" permanently !'),
      theWidgetButton: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.cyan),
        ),
        onPressed: widget.theOnPressed,
        icon: customeIcon(theIcon: Icons.delete_forever_outlined),
        label: customeText(theData: 'Delete'),
      ),
    );
  }
}
