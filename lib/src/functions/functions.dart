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
// BoxDecoration ebackgroundGradientCyan() {
//   return BoxDecoration(
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
