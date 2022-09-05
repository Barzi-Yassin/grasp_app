import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/auth/complete_profile/screen_set_user_profile_image.dart';

class ScreenSetUserProfileName extends StatelessWidget {
  ScreenSetUserProfileName({
    Key? key,
    required this.theUser,
  }) : super(key: key);
  final User theUser;
  final TextEditingController controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: backgroundGradientCyan(),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              customeTextAuthHeader(theData: '• Username •'),
              const SizedBox(height: 100),
              customeText(theData: theUser.uid.toString()),
              customeText(theData: theUser.email.toString()),
              const SizedBox(height: 100),
              Form(
                child: TextFormField(
                  controller: controllerUsername,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.cyan,
                  onSaved: (username) {},
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Username',
                    prefixIcon: customePaddingOnly(
                      thePaddingLeft: 10,
                      theChild: customeIconShaderMask(
                        // theIcon: Icons.person_pin_outlined,
                        theIcon: Icons.person_outline,
                        theSize: 28,
                      ),
                    ),
                    suffixIcon: customePaddingOnly(
                      thePaddingRight: 10,
                      theChild: customeIconButton(
                        theOnPressed: () => controllerUsername.clear(),
                        theIcon: Icons.close,
                        theSize: 22,
                        theColor: Colors.grey.shade400,
                      ),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.to(ScreenSetUserprofileImage(theControllerUsername: 'batala!', theUser: theUser)),
                    child: customeText(theData: 'SKIP'),
                  ),
                  const SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () => Get.to(ScreenSetUserprofileImage(
                      theControllerUsername: controllerUsername.text.toString(),
                      theUser: theUser,
                    )),
                    child: customeText(theData: 'Next'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
