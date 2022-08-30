import 'package:flutter/material.dart';
import 'package:grasp_app/src/functions/functions.dart';
import 'package:grasp_app/src/widgets/end_drawer/widget_end_drawer.dart';

class ScreenFilterStars extends StatelessWidget {
  const ScreenFilterStars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SafeArea(
        child: EndDrawer(),
      ),
      appBar: AppBar(
        leading: functionArrowbackIconButton(context),
        title: const Text('Stars'),
      ),
    );
  }
}