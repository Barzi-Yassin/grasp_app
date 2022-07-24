import 'package:flutter/material.dart';

import 'sizing.dart';
import 'util.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, boxConstraints) {
      var sizinginformation = SizingInformation(
        orientation: mediaquery.orientation,
        deviceScreenType: getDeviceType(mediaquery.size),
        screenSize: mediaquery.size,
        localWidgetSize:
            Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      return builder(context, sizinginformation);
    });
  }

  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;
}
