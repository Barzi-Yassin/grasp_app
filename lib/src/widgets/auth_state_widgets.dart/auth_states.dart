import 'package:flutter/material.dart';
import 'package:grasp_app/src/functions/functions.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({Key? key, required this.theControllerEmail})
      : super(key: key);

  final TextEditingController theControllerEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: theControllerEmail,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.cyan,
      onSaved: (email) {},
      maxLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        hintText: "Your email",
        prefixIcon: customePaddingOnly(
          thePaddingLeft: 10,
          theChild: customeIconShaderMask(
            theIcon: Icons.person_outline,
            theSize: 28,
          ),
        ),
        suffixIcon: customePaddingOnly(
          thePaddingRight: 10,
          theChild: customeIconButton(
            theOnPressed: () => theControllerEmail.clear(),
            theIcon: Icons.close,
            theSize: 22,
            theColor: Colors.grey.shade400,
          ),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide.none),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  const InputPassword({Key? key, required this.theControllerPassword})
      : super(key: key);
  final TextEditingController theControllerPassword;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  IconData passwordHideShowIconHandler = Icons.visibility_off;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidePassword,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      cursorColor: Colors.cyan,
      onSaved: (password) {},
      maxLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        hintText: "Password",
        prefixIcon: customePaddingOnly(
          thePaddingLeft: 10,
          theChild: customeIconShaderMask(
            theIcon: Icons.lock_outline,
            theSize: 27,
          ),
        ),
        suffixIcon: customePaddingOnly(
          thePaddingRight: 10,
          theChild: customeIconButton(
            theOnPressed: () => setState(() {
              hidePassword = !hidePassword;
              debugPrint(hidePassword.toString());
              if (hidePassword) {
                passwordHideShowIconHandler = Icons.visibility_off;
              } else {
                passwordHideShowIconHandler = Icons.visibility_sharp;
              }
            }),
            theIcon: passwordHideShowIconHandler,
            theSize: 21,
            theColor: Colors.grey.shade400,
          ),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide.none),
      ),
    );
  }
}

