import 'package:flutter/material.dart';

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
