import 'package:flutter/material.dart';
import 'package:grasp_app/src/functions/functions.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({Key? key}) : super(key: key);

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade800,
      appBar: AppBar(
        // elevation: 4,
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
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
                  TextFormField(
                    controller: controllerEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    focusNode: FocusNode(),
                    controller: controllerPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(onPressed: () {
              debugPrint('controllerEmail= <${controllerEmail.text}>');
              debugPrint('controllerPassword= <${controllerPassword.text}>');
            }, child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
