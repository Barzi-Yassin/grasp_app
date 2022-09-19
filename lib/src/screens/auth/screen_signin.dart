import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/widgets/auth_state_widgets.dart/auth_states.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/auth/screen_signup.dart';
import 'package:grasp_app/src/screens/main_screens/screen_subjects.dart';
import 'package:grasp_app/src/services/firebase/service_auth.dart';

class ScreenSignin extends StatefulWidget {
  const ScreenSignin({Key? key}) : super(key: key);

  @override
  State<ScreenSignin> createState() => _ScreenSigninState();
}

class _ScreenSigninState extends State<ScreenSignin> {
  final TextEditingController controllerSigninEmail = TextEditingController();
  final TextEditingController controllerSigninPassword =
      TextEditingController();

  final ServiceAuth serviceAuth = ServiceAuth();
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
                        theData: '• sign in •', theFontSize: 30),
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
                                    theControllerEmail: controllerSigninEmail),

                                const SizedBox(height: 20),

                                // password
                                InputPassword(
                                    theControllerPassword:
                                        controllerSigninPassword),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (controllerSigninEmail.text.isNotEmpty &&
                                  controllerSigninPassword.text.isNotEmpty) {
                                setState(() => isLoading = true);
                                debugPrint(
                                    'controllerSigninEmail= <${controllerSigninEmail.text}>');
                                debugPrint(
                                    'controllerSigninPassword= <${controllerSigninPassword.text}>');
                                await serviceAuth
                                    .signInUserWithEmailAndPassword(
                                  signInemail:
                                      controllerSigninEmail.text.trim(),
                                  signInpass: controllerSigninPassword.text,
                                )
                                    .then(
                                  (credential) {
                                    if (credential != null) {
                                      debugPrint(
                                        'controllerSigninEmail= <${controllerSigninEmail.text}>',
                                      );
                                      setState(() {
                                        isLoading = false;
                                        controllerSigninEmail.clear();
                                        controllerSigninPassword.clear();
                                      });
                                      Get.offAll(
                                        ScreenSubjects(
                                          theUser: credential.user!,
                                        ),
                                      );
                                    }
                                    setState(() => isLoading = false);
                                  },
                                );
                              } else {
                                debugPrint(
                                    'one field or more might be empty !');
                                Get.snackbar('Sign in caution',
                                    'One field or more might be empty!');
                              }
                            },
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          controllerSigninEmail.clear();
                          controllerSigninPassword.clear();
                        });
                        Get.offAll(() => const ScreenSignup());
                      },
                      child: customeText(
                        theData: '\nDon\'t Have Account? \nSign up here',
                        theTextAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
