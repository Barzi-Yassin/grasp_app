import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/widgets/auth_state_widgets.dart/auth_states.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/auth/screen_signup.dart';

class ScreenSignin extends StatelessWidget {
  ScreenSignin({Key? key}) : super(key: key);

  final TextEditingController controllerSigninEmail = TextEditingController();
  final TextEditingController controllerSigninPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Container(
        decoration: backgroundGradientCyan(),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.vertical,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              customeTextAuthHeader(theData: '• sign in •'),
              const SizedBox(height: 100),
              Form(
                child: Column(
                  children: [
                    // email
                    InputEmail(theControllerEmail: controllerSigninEmail),

                    const SizedBox(height: 20),

                    // password
                    InputPassword(
                        theControllerPassword: controllerSigninPassword),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint(
                      'controllerSigninEmail= <${controllerSigninEmail.text}>');
                  debugPrint(
                      'controllerSigninPassword= <${controllerSigninPassword.text}>');
                },
                child: const Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => ScreenSignup());
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
