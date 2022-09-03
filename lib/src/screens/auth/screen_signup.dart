import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/widgets/auth_state_widgets.dart/auth_states.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/auth/screen_signin.dart';

class ScreenSignup extends StatelessWidget {
  ScreenSignup({Key? key}) : super(key: key);

  final TextEditingController controllerSignupEmail = TextEditingController();
  final TextEditingController controllerSignupPassword =
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
              customeTextAuthHeader(theData: '• sign up •'),
              const SizedBox(height: 100),
              Form(
                child: Column(
                  children: [
                    // email
                    InputEmail(theControllerEmail: controllerSignupEmail),

                    const SizedBox(height: 20),

                    // password
                    InputPassword(
                        theControllerPassword: controllerSignupPassword),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint(
                      'controllerSignupEmail= <${controllerSignupEmail.text}>');
                  debugPrint(
                      'controllerSignupPassword= <${controllerSignupPassword.text}>');
                },
                child: const Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => ScreenSignin());
                },
                child: customeText(
                  theData: '\nAlready Have an Account? \nSign in here',
                  theTextAlign: TextAlign.center
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
