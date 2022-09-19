import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';

class ScreenGraspGuidance extends StatelessWidget {
  const ScreenGraspGuidance({Key? key, this.theUser}) : super(key: key);
  final User? theUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      endDrawer: SafeArea(
        child: EndDrawer(theUser: theUser),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        leading: functionArrowbackIconButton(context),
        title: const Text('Grasp Guidance'),
      ),
      body: Container(
        decoration: backgroundGradientCyan(),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: customeText(
            theData: 'Not implemented yet!',
            theFontSize: 20,
            theColor: Colors.black54,
            theLetterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
