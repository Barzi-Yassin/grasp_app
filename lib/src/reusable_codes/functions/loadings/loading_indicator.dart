import 'package:flutter/material.dart';

Center loadingIndicator({Color? theColor}) {
  return Center(
    child: CircularProgressIndicator(
      color: theColor ?? Colors.blueGrey,
    ),
  );
}
