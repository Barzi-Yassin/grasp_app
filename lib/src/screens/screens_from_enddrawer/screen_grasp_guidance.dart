import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/data/datalist_grasp_gidance.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/grasp_guidance/widget_grasp_guidance_expansion_tile.dart';
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
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemCount: datalistGraspGuidance.length,
          itemBuilder: (context, theIndex) {
            return WidgetGraspGuidanceExpansionTile(
              graspGuidanceId: datalistGraspGuidance[theIndex]
                      ["grasp_guidance_id"]
                  .toString(),
              graspGuidanceTitle: datalistGraspGuidance[theIndex]
                      ["grasp_guidance_title"]
                  .toString(),
              graspGuidanceDescription: datalistGraspGuidance[theIndex]
                      ["grasp_guidance_description"]
                  .toString(),
            );
          },
        ),
        // child: Center(
        //   child: customeText(
        //     theData: 'Not implemented yet!',
        //     theFontSize: 20,
        //     theColor: Colors.black54,
        //     theLetterSpacing: 1,
        //   ),
        // ),
      ),
    );
  }
}
