import 'package:flutter/material.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            // color: const Color.fromARGB(255, 60, 60, 60),
            color: Colors.black87,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'Grasp'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.white70,
                  ),
                ),
                Positioned(
                  bottom: 70,
                  child: Text(
                    'save your grasp here'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      // fontFamily: 'Caveat-Bold',
                      letterSpacing: 3,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
