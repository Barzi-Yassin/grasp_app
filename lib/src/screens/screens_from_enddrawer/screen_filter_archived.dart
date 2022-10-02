import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class ScreenFilterArchived extends StatelessWidget {
  const ScreenFilterArchived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: functionArrowbackIconButton(context),
        title: customeText(
            theData: 'Archived Grasps'), // change to custome widgets
      ),
    );
  }
}
