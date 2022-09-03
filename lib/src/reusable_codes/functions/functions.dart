import 'package:flutter/material.dart';

// screen body gradient
BoxDecoration backgroundGradientCyan() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.cyan.shade300,
        Colors.grey.shade400,
      ],
    ),
  );
}

// dialog header gradient
LinearGradient dialogHeaderGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.cyan.shade700,
      Colors.cyan.shade100,
      // Colors.white,
    ],
  );
}

//  arrow back to previous screen
IconButton functionArrowbackIconButton(BuildContext context) {
  return IconButton(
    onPressed: () => Navigator.pop(context),
    icon: const Icon(Icons.arrow_back),
  );
}

IconButton customeIconButton(
    {required theOnPressed,
    required IconData theIcon,
    double? theSize,
    Color? theColor}) {
  return IconButton(
      onPressed: theOnPressed,
      icon: Icon(
        theIcon,
        size: theSize,
        color: theColor,
      ));
}

Icon customeIcon(
    {required IconData theIcon, double? theSize, Color? theColor}) {
  return Icon(
    theIcon,
    size: theSize,
    color: theColor,
  );
}

Padding customePaddingAll(
    {required double thePaddingAll, required Widget theChild}) {
  return Padding(
    padding: EdgeInsets.all(thePaddingAll),
    child: theChild,
  );
}

Padding customePaddingSymmetric(
    { double? thePaddingHorizantal,
     double? thePaddingVertical,
    required Widget theChild}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: thePaddingHorizantal ?? 0, vertical: thePaddingVertical ?? 0),
    child: theChild,
  );
}

Padding customePaddingLTBR({
  required double thePaddingLeft,
  required double thePaddingTop,
  required double thePaddingRight,
  required double thePaddingBottom,
  required Widget theChild,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      thePaddingLeft,
      thePaddingTop,
      thePaddingRight,
      thePaddingBottom,
    ),
    child: theChild,
  );
}

Padding customePaddingOnly(
    {double? thePaddingLeft, double? thePaddingTop, double? thePaddingRight, double? thePaddingBottom, required Widget theChild}) {
  return Padding(
    padding: EdgeInsets.only(left: thePaddingLeft ?? 0, top: thePaddingTop ?? 0, right: thePaddingRight ?? 0, bottom: thePaddingBottom ?? 0),
    child: theChild,
  );
}


ShaderMask customeIconShaderMask(
    {required IconData theIcon, required double theSize}) {
  return ShaderMask(
    shaderCallback: (bounds) => RadialGradient(
      center: Alignment.center,
      radius: 0.325,
      colors: [Colors.pink.shade200, Colors.cyan.shade200],
      tileMode: TileMode.decal,
    ).createShader(bounds),
    child: Icon(
      theIcon,
      size: theSize,
      color: Colors.white,
    ),
  );
}
