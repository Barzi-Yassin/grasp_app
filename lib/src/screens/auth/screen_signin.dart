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
                    customeTextGraspHeader(
                        theData: '• grasp •', theFontSize: 50),
                    SizedBox(height: screenHeight * 0.06),
                    customeTextAuthHeader(theData: 'sign in', theFontSize: 30),
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
                                Material(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(45),
                                  elevation: 2,
                                  child: InputEmail(
                                      theControllerEmail:
                                          controllerSigninEmail),
                                ),

                                const SizedBox(height: 20),

                                // password
                                Material(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(45),
                                  elevation: 2,
                                  child: InputPassword(
                                      theControllerPassword:
                                          controllerSigninPassword),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
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
                                customeSnackbar(
                                  theTitle: 'Sign in caution',
                                  theMessage:
                                      'One field or more might be empty!',
                                );
                              }
                            },
                            label: customeText(
                              theData: ' SIGN IN',
                              theLetterSpacing: 1,
                              theFontSize: 20,
                              theFontWeight: FontWeight.w600,
                              theFontFamily: 'MavenPro',
                            ),
                            icon: customeIcon(theIcon: Icons.login),
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.cyan),
                              animationDuration:
                                  const Duration(milliseconds: 20),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 0.2,
                                  ),
                                ),
                              ),
                            ),
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
                        theData: '\nDon\'t have account? \nSign up here',
                        theTextAlign: TextAlign.center,
                        theColor: Colors.cyan.shade700,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
