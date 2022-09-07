import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';

class ScreenGraspGuidance extends StatelessWidget {
  const ScreenGraspGuidance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(
        child: EndDrawer(),
      ),
      appBar: AppBar(
        leading: functionArrowbackIconButton(context),
        title: const Text('Grasp Guidance'),
      ),
    );
  }
}