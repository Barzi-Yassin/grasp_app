import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/auth/complete_profile/screen_set_user_profile_image.dart';

class ScreenSetUserProfileName extends StatelessWidget {
  ScreenSetUserProfileName({Key? key}) : super(key: key);

  final TextEditingController ontrollerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: backgroundGradientCyan(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                child: TextFormField(
                  controller: ontrollerUsername,
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
                        theOnPressed: () => ontrollerUsername.clear(),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(ScreenSetUserprofileImage());
                },
                child: customeText(theData: 'Next'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
