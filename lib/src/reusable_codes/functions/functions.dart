import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

// appbar title (folder icon + folder name)
Row appbarTitleFolderIconAndName({required String theFolderaName}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const FaIcon(
        FontAwesomeIcons.solidFolderOpen,
        size: 19,
      ),
      const SizedBox(width: 8),
      Expanded(
        child: customeText(
          theData: theFolderaName,
          theMaxLines: 1,
          theTextAlign: TextAlign.center,
        ),
      ),
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

IconButton customeIconButton({
  required theOnPressed,
  required IconData theIcon,
  double? theSize,
  Color? theColor,
  Alignment? theAlignment,
  double? theSplashRadius,
  double? thePaddingLeft,
  double? thePaddingTop,
  double? thePaddingRight,
  double? thePaddingBottom,
}) {
  return IconButton(
      onPressed: theOnPressed,
      constraints: BoxConstraints.tight(
        const Size.fromRadius(18),
      ),
      padding: EdgeInsets.only(
        left: thePaddingLeft ?? 0,
        top: thePaddingTop ?? 0,
        right: thePaddingRight ?? 0,
        bottom: thePaddingBottom ?? 0,
      ),
      alignment: theAlignment ?? Alignment.center,
      // color: Colors.amber,
      // focusColor: Colors.orange,
      // hoverColor: Colors.amber,
      // disabledColor: Colors.grey.shade400,
      splashColor: Colors.cyan.shade800,
      highlightColor: Colors.cyan.shade700,
      splashRadius: theSplashRadius ?? 15,
      icon: Icon(
        theIcon,
        size: theSize,
        color: theColor,
      ));
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

// ShaderMask customeIconButtonShaderMask({
//   required IconData theIcon,
//   required double theSize,
//   double? theRadius,
//   Color? theColor1,
//   Color? theColor2,
//   TileMode? theTileMode,
// }) {
//   return ShaderMask(
//     shaderCallback: (bounds) => RadialGradient(
//       center: Alignment.center,
//       radius: theRadius ?? 0.325,
//       colors: [
//         theColor1 ?? Colors.pink.shade200,
//         theColor2 ?? Colors.cyan.shade200,
//       ],
//       tileMode: theTileMode ?? TileMode.decal,
//     ).createShader(bounds),
//     child: Icon(
//       theIcon,
//       size: theSize,
//       color: Colors.white,
//     ),
//   );
// }

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

Text customeTextAuthHeader({
  required String theData,
  // Color? theColor,
  // int? theMaxLines,
  double? theFontSize,
}) {
  return Text(
    theData.toUpperCase(),
    maxLines: 1,
    style: const TextStyle(
        color: Colors.blueGrey,
        fontWeight: FontWeight.w800,
        fontFamily: 'MavenPro',
        fontSize: 22,
        letterSpacing: 1,
        // foreground: Paint()
        //   ..style = PaintingStyle.fill
        //   ..strokeWidth = 1.0
        //   ..color = Colors.blueGrey
        // // ..invertColors = true
        ),
  );
}

Text customeTextGraspHeader({
  required String theData,
  // Color? theColor,
  // int? theMaxLines,
  double? theFontSize,
}) {
  return Text(
    theData.toUpperCase(),
    maxLines: 1,
    style: TextStyle(
        // color: theColor,
        fontWeight: FontWeight.w800,
        fontFamily: 'Caveat',
        fontSize: 40,
        letterSpacing: 8,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..color = Colors.teal
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

Column noItemFound(
    {required String theItemName, required double theScreenHeight}) {
  return Column(
    children: [
      SizedBox(height: (theScreenHeight / 3)),
      customeText(
        theData: '4🧐4',
        theFontFamily: 'MavenPro',
        theFontWeight: FontWeight.bold,
        theTextAlign: TextAlign.center,
        theFontSize: 40,
      ),
      const SizedBox(height: 5),
      customeText(
          theData: 'No $theItemName found!',
          theFontFamily: 'MavenPro',
          theFontWeight: FontWeight.bold,
          theTextAlign: TextAlign.center,
          theLetterSpacing: 1),
    ],
  );
}
