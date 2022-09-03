import 'package:flutter/material.dart';
import 'package:grasp_app/src/widgets/auth_state_widgets.dart/auth_states.dart';
import 'package:grasp_app/src/functions/functions.dart';

class ScreenSignup extends StatelessWidget {
  ScreenSignup({Key? key}) : super(key: key);

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Container(
        decoration: backgroundGradientCyan(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              child: Column(
                children: [
                  // TextFormField(
                  //   // controller: controller,
                  //   textAlign: TextAlign.center,
                  //   decoration: InputDecoration(

                  //       // alignLabelWithHint: true,
                  //       floatingLabelAlignment: FloatingLabelAlignment.center,
                  //       // prefixIcon: Icon(Icons.close),
                  //       suffixIcon: IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(
                  //             Icons.close,
                  //             color: Color.fromARGB(255, 126, 50, 50),
                  //           )),
                  //       border: const UnderlineInputBorder(),
                  //       hintText: 'name',
                  //       // labelText: 'Grasp name2',
                  //       alignLabelWithHint: true),
                  // ),

                  // email
                  InputEmail(theControllerEmail: controllerEmail),

                  const SizedBox(height: 20),

                  // password
                  InputPassword(theControllerPassword: controllerPassword),

                  

                  // TextFormField(
                  //   controller: controllerEmail,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Email',
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // TextFormField(
                  //   focusNode: FocusNode(),
                  //   controller: controllerPassword,
                  //   obscureText: true,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Password',
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  debugPrint('controllerEmail= <${controllerEmail.text}>');
                  debugPrint(
                      'controllerPassword= <${controllerPassword.text}>');
                },
                child: const Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
