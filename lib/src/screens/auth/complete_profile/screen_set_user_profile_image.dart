import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class ScreenSetUserprofileImage extends StatelessWidget {
  ScreenSetUserprofileImage({Key? key}) : super(key: key);

  final TextEditingController ontrollerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundGradientCyan(),
        child: Center(
          child: SizedBox(
            height: 210,
            width: 210,
            child: Badge(
              padding: const EdgeInsets.all(10),
              gradient: LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [
                  Colors.grey.shade500,
                  Colors.grey.shade400,
                  Colors.cyan.shade300,
                  Colors.cyan.shade200,
                ],
              ),

              borderSide: const BorderSide(color: Colors.white, width: 2),
              elevation: 0,
              position: BadgePosition.bottomEnd(bottom: 10, end: 12),
              // padding: EdgeInsetsDirectional.only(end: 4),
              badgeColor: Colors.cyan.shade200,
              badgeContent: const Icon(
                Icons.add_a_photo_outlined,
                size: 25.0,
                color: Colors.white,
                shadows: [
                  BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                  BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                  BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                  BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                ],
              ),
              showBadge: true,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
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
      ),
    );
  }
}
