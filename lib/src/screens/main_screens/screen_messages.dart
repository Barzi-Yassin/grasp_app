import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class ScreenMessages extends StatefulWidget {
  const ScreenMessages({
    super.key,
    required this.theUser,
    required this.theFileName,
    required this.theFileSubjectName,
  });

  final User theUser;
  final String theFileName;
  final String theFileSubjectName;

  @override
  State<ScreenMessages> createState() => _ScreenMessagesState();
}

class _ScreenMessagesState extends State<ScreenMessages> {
  final TextEditingController controllerMessage = TextEditingController();

  // var focusNode = FocusNode();
  // @override
  // void initState() {
  //   focusNode.addListener(() {
  //     debugPrint(focusNode.hasFocus.toString());
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade700,
          centerTitle: true,
          title: Text('${widget.theFileSubjectName} > ${widget.theFileName}'),
        ),
        body: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: double.infinity,
          width: double.infinity,
          decoration: backgroundGradientCyan(),
          child: Badge(
            // toAnimate: false,
            animationType: BadgeAnimationType.fade,
            animationDuration: const Duration(milliseconds: 700),
            // padding: const EdgeInsets.all(10),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Colors.grey.shade400,
            //     Colors.cyan.shade200,
            //   ],
            // ),
            elevation: 0,
            position: BadgePosition.topStart(start: 5, top: 10),
            // borderSide: const BorderSide(color: Colors.white60, width: 1),
            badgeColor: Colors.transparent,
            showBadge: true,
            badgeContent: Container(
              height: 50,
              width: screenWidth - 20,
              // child: customeText(theData: 'fffffff'),
              decoration: BoxDecoration(
                  // color: Colors.cyan,
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.white,
                      // Colors.grey.shade100,
                      // Colors.grey.shade300,
                    ],
                  )),
              child: customeIconButton(
                  theOnPressed: () {
                    debugPrint(screenWidth.toString());
                    debugPrint({screenWidth / 2}.toString());
                  },
                  theIcon: Icons.add),
            ),
            child: Container(
              margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 40, bottom: 5),
              padding: const EdgeInsets.only(top: 22.5),
              width: double.infinity,
              // height: 200,
              // alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey.shade300, width: 2.5),
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(34), top: Radius.circular(5)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        // height: double.infinity,
                        // width: 20,
                        // color: Colors.blue,
                        ),
                  ),
                  Container(
                    // height: 50,
                    width: screenWidth - 20,
                    // child: customeText(theData: 'fffffff'),
                    decoration: BoxDecoration(
                      // color: Colors.cyan,
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.grey.shade300,
                          Colors.grey.shade200,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: TextFormField(
                      // focusNode: focusNode,
                      controller: controllerMessage,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      cursorColor: Colors.cyan,
                      onSaved: (message) {},
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        hintText: "Message...",
                        prefixIcon: customePaddingOnly(
                          thePaddingLeft: 10,
                          theChild: customeIconShaderMask(
                            theIcon: Icons.emoji_emotions_outlined,
                            theSize: 28,
                          ),
                        ),
                        suffixIcon: customePaddingOnly(
                          thePaddingRight: 10,
                          theChild: customeIconButton(
                            theOnPressed: () => controllerMessage.clear(),
                            theIcon: Icons.close,
                            theSize: 22,
                            theColor: Colors.grey.shade400,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
