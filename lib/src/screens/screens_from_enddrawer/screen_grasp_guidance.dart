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
        leading: functionArrowbackIconButton(context),
        title: const Text('Grasp Guidance'),
      ),
    );
  }
}
