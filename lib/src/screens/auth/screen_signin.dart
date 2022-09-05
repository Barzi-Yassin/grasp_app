import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/widgets/auth_state_widgets.dart/auth_states.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/screens/auth/screen_signup.dart';
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

  ServiceAuth serviceAuth = ServiceAuth();

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
                onPressed: () async {
                  debugPrint(
                      'controllerSigninEmail= <${controllerSigninEmail.text}>');
                  debugPrint(
                      'controllerSigninPassword= <${controllerSigninPassword.text}>');
                  await serviceAuth.signInUserWithEmailAndPassword(
                    signInemail: controllerSigninEmail.text.trim(),
                    signInpass: controllerSigninPassword.text,
                  ).then((value) => debugPrint(
                      'controllerSigninEmail= <${controllerSigninEmail.text}>'));
                },
                child: const Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const ScreenSignup());
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
