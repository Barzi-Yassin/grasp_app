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
          theChild: customeIcon(
            theIcon: Icons.person,
            theColor: Colors.cyan.shade900,
            theSize: 27
          ),
        ),
        suffixIcon: customePaddingOnly(
          thePaddingRight: 10,
          theChild: customeIconButton(
            theOnPressed: () => theControllerEmail.clear(),
            theIcon: Icons.close,
            theSize: 25,
            theColor: Colors.brown.shade300,
          ),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide.none),
      ),
    );
  }
}

Widget inputPassword({required TextEditingController thePassword}) {
  return TextFormField(
    obscureText: true,
    textAlign: TextAlign.center,
    // keyboardType: TextInputType.visiblePassword,
    textInputAction: TextInputAction.done,
    cursorColor: Colors.cyan,
    onSaved: (password) {},
    maxLines: 1,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white70,
      hintText: "Your password",
      prefixIcon: customePaddingOnly(
        thePaddingLeft: 10,
        theChild: customeIcon(
            theIcon: Icons.lock, theColor: Colors.pink.shade300, theSize: 26),
      ),
      suffixIcon: customePaddingOnly(
        thePaddingRight: 10,
        theChild: customeIconButton(
          theOnPressed: () {},
          theIcon: Icons.visibility_off_sharp,
          theSize: 25,
          theColor: Colors.pink.shade300,
        ),
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide.none),
    ),
  );
}