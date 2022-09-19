import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/auth_state_widgets.dart/auth_states.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/screens/auth/complete_profile/screen_set_user_profile_name.dart';
import 'package:grasp_app/src/screens/auth/screen_signin.dart';
import 'package:grasp_app/src/services/firebase/service_auth.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({Key? key}) : super(key: key);

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final ServiceAuth serviceAuth = ServiceAuth();
  final ServiceFirestore serviceFirestore = ServiceFirestore();

  final TextEditingController controllerSignupEmail = TextEditingController();
  final TextEditingController controllerSignupPassword =
      TextEditingController();

  IconData passwordHideShowIconHandler = Icons.visibility_off;
  bool hidePassword = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Container(
        decoration: backgroundGradientCyan(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: isLoading == true
            ? loadingIndicator()
            : SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.15),
                    customeTextGraspHeader(theData: 'grasp', theFontSize: 50),
                    SizedBox(height: screenHeight * 0.06),
                    customeTextAuthHeader(
                        theData: '• sign up •', theFontSize: 30),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Form(
                            child: Column(
                              children: [
                                // email
                                InputEmail(
                                  theControllerEmail: controllerSignupEmail,
                                ),

                                const SizedBox(height: 20),

                                // password
                                InputPassword(
                                  theControllerPassword:
                                      controllerSignupPassword,
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (controllerSignupEmail.text.isNotEmpty &&
                                  controllerSignupPassword.text.isNotEmpty) {
                                debugPrint(
                                    'controllerSignupEmail= <${controllerSignupEmail.text}>'); //  TODO: temporary
                                debugPrint(
                                    'controllerSignupPassword= <${controllerSignupPassword.text}>'); //  TODO: temporary

                                setState(() => isLoading = true);
                                await serviceAuth
                                    .signUpUserWithEmailAndPassword(
                                  signUpemail:
                                      controllerSignupEmail.text.trim(),
                                  signUppass: controllerSignupPassword.text,
                                )
                                    .then(
                                  (credential) async {
                                    if (credential != null) {
                                      debugPrint('user created DONE');
                                      await serviceFirestore
                                          .addUserToDB(user: credential.user!)
                                          .then((value) async {
                                        setState(() {
                                          isLoading = false;
                                          controllerSignupEmail.clear();
                                          controllerSignupPassword.clear();
                                        });
                                        await Get.offAll(
                                          ScreenSetUserProfileName(
                                            theUser: credential.user!,
                                          ),
                                        );
                                      });
                                    }
                                    setState(() => isLoading = false);
                                  },
                                );
                              } else {
                                debugPrint(
                                    'one field or more might be empty !');
                                Get.snackbar('Sign up caution',
                                    'One field or more might be empty!');
                              }
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          controllerSignupEmail.clear();
                          controllerSignupPassword.clear();
                        });
                        Get.to(() => const ScreenSignin());
                      },
                      child: customeText(
                          theData: '\nAlready Have an Account? \nSign in here',
                          theTextAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
