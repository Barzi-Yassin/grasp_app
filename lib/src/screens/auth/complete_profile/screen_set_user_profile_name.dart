import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/auth/complete_profile/screen_set_user_profile_image.dart';

class ScreenSetUserProfileName extends StatefulWidget {
  const ScreenSetUserProfileName({
    Key? key,
    required this.theUser,
  }) : super(key: key);
  final User theUser;

  @override
  State<ScreenSetUserProfileName> createState() =>
      _ScreenSetUserProfileNameState();
}

class _ScreenSetUserProfileNameState extends State<ScreenSetUserProfileName> {
  final TextEditingController controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.grey.shade400,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: backgroundGradientCyan(),
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.vertical,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
              .manual, // TODO: check i guess it causes bad UX
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.15),
              customeTextGraspHeader(theData: '• grasp •', theFontSize: 50),
              SizedBox(height: screenHeight * 0.06),
              customeTextAuthHeader(theData: 'Username', theFontSize: 30),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      child: TextFormField(
                        controller: controllerUsername,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.cyan,
                        onSaved: (username) {},
                        maxLines: 1,
                        maxLength: 15,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() => controllerUsername.clear());
                            Get.to(ScreenSetUserprofileImage(
                              theControllerUsername:
                                  controllerUsername.text.toString(),
                              theUser: widget.theUser,
                            ));
                          },
                          style: customeButtonStyle(),
                          child: customeText(
                            theData: 'SKIP',
                            theLetterSpacing: 1,
                            theFontSize: 17,
                            theFontWeight: FontWeight.w600,
                            theFontFamily: 'MavenPro',
                          ),
                        ),
                        const SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () {
                            String temp = controllerUsername.text;
                            // debugPrint('wwwwwww :: 1 ::  <$temp>');
                            temp = temp.replaceAll(" ", "");
                            // debugPrint('wwwwwww :: 2 ::  <$temp>');
                            if (temp.isNotEmpty) {
                              Get.to(
                                ScreenSetUserprofileImage(
                                  theControllerUsername:
                                      controllerUsername.text.toString(),
                                  theUser: widget.theUser,
                                ),
                              );
                            } else {
                              // debugPrint('wwwwwww :: 2 :: Try not to input spaces only!');
                              customeSnackbar(
                                theTitle: 'Username caution',
                                theMessage: 'Try not to input spaces only!',
                              );
                            }
                          },
                          style: customeButtonStyle(),
                          child: customeText(
                            theData: 'Next',
                            theLetterSpacing: 1,
                            theFontSize: 17,
                            theFontWeight: FontWeight.w600,
                            theFontFamily: 'MavenPro',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
