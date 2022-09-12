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

// // screen body gradient
// BoxDecoration messagesContainer() {
//   return BoxDecoration(
//     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
//     border: const Border(
//       top: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
//       bottom: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
//       left: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
//       right: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
//     ),
//     gradient: LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Colors.cyan.shade300,
//         Colors.grey.shade400,
//       ],
//     ),
//   );
// }

// // screen body gradient
// BoxDecoration messagesContainerHeader() {
//   return BoxDecoration(
//     borderRadius: BorderRadius.circular(180),
//     border: Border.all(color: Colors.white),
//   );
// }

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
      constraints: BoxConstraints.tight(const Size.fromRadius(18),),
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
    {double? thePaddingHorizantal,
    double? thePaddingVertical,
    required Widget theChild}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: thePaddingHorizantal ?? 0,
        vertical: thePaddingVertical ?? 0),
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
    {double? thePaddingLeft,
    double? thePaddingTop,
    double? thePaddingRight,
    double? thePaddingBottom,
    required Widget theChild}) {
  return Padding(
    padding: EdgeInsets.only(
        left: thePaddingLeft ?? 0,
        top: thePaddingTop ?? 0,
        right: thePaddingRight ?? 0,
        bottom: thePaddingBottom ?? 0),
    child: theChild,
  );
}

ShaderMask customeIconShaderMask({
  required IconData theIcon,
  required double theSize,
  double? theRadius,
  Color? theColor1,
  Color? theColor2,
  TileMode? theTileMode,
}) {
  return ShaderMask(
    shaderCallback: (bounds) => RadialGradient(
      center: Alignment.center,
      radius: theRadius ?? 0.325,
      colors: [
        theColor1 ?? Colors.pink.shade200,
        theColor2 ?? Colors.cyan.shade200,
      ],
      tileMode: theTileMode ?? TileMode.decal,
    ).createShader(bounds),
    child: Icon(
      theIcon,
      size: theSize,
      color: Colors.white,
    ),
  );
}

Text customeTextAuthHeader({
  required String theData,
  Color? theColor,
  int? theMaxLines,
  double? theFontSize,
}) {
  return Text(
    theData.toUpperCase(),
    maxLines: theMaxLines,
    style: TextStyle(
        color: theColor,
        fontWeight: FontWeight.w800,
        fontFamily: 'Caveat',
        fontSize: 40,
        letterSpacing: 3,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = Colors.brown
        // ..invertColors = true
        ),
  );
}

Text customeText({
  required String theData,
  Color? theColor,
  TextAlign? theTextAlign,
  FontWeight? theFontWeight,
  String? theFontFamily,
  double? theFontSize,
  double? theWordSpacing,
  double? theLetterSpacing,
  int? theMaxLines,
}) {
  return Text(
    theData,
    maxLines: theMaxLines,
    textAlign: theTextAlign,
    style: TextStyle(
      color: theColor,
      fontWeight: theFontWeight,
      fontFamily: theFontFamily,
      fontSize: theFontSize,
      wordSpacing: theWordSpacing,
      letterSpacing: theLetterSpacing,
    ),
  );
}
