import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class ScreenSetUserprofileImage extends StatelessWidget {
  const ScreenSetUserprofileImage(
      {Key? key, required this.theControllerUsername})
      : super(key: key);

  final String theControllerUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            customeTextAuthHeader(theData: '• profile •'),
            const SizedBox(height: 100),
            SizedBox(
              height: 210,
              width: 210,
              child: InkWell(
                onTap: () {},
                child: Badge(
                  padding: const EdgeInsets.all(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade400,
                      Colors.cyan.shade200,
                      // Colors.white,
                      // Colors.white,
                    ],
                  ),
                  borderSide: const BorderSide(color: Colors.white60, width: 1),
                  elevation: 0,
                  position: BadgePosition.topStart(start: 10, top: 12),
                  badgeColor: Colors.cyan.shade200,
                  badgeContent: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 25.0,
                    color: Colors.white70,
                    // shadows: [
                    //   BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                    //   // BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   // BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   // BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                    // ],
                  ),
                  showBadge: true,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white60, width: 2.0),
                    ),
                    alignment: Alignment.center,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/3.jpeg'),
                      radius: 100,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: customeText(theData: 'SKIP'),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {},
                  child: customeText(theData: 'SAVE'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
