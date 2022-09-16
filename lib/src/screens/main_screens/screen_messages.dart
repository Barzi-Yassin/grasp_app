import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_delete.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';

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
  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final DateTimeOptimizer dateTimeOptimizer = DateTimeOptimizer();
  final CustomeStringFunctions customeStringFunctions =
      CustomeStringFunctions();

  final TextEditingController controllerMessage = TextEditingController();

  final FocusNode focusNodeMessage = FocusNode();

  bool isDateVisibile = false;
  bool isReadingMode = false;

  // @override
  // void initState() {
  //   // focusNode.addListener(() {
  //   //   debugPrint(focusNode.hasFocus.toString());
  //   // });
  //   controllerMessage.addListener(() => setState(() {}));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    debugPrint('test width :: $screenWidth');
    debugPrint('test height:: $screenHeight');

    final String isReadingModeAppbarTitle =
        '${customeStringFunctions.customeSubString(theString: widget.theFileSubjectName, theResultLengthLimit: 4)}/ ${customeStringFunctions.customeSubString(theString: widget.theFileName, theResultLengthLimit: 4)}';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade700,
          // centerTitle: true,
          // title: Text('${widget.theFileSubjectName} > ${widget.theFileName}'),
          title: appbarTitleFolderIconAndName(
              theFolderaName: isReadingMode
                  ? isReadingModeAppbarTitle
                  : widget.theFileSubjectName),
          actions: [
            customeIconButton(
              theOnPressed: () =>
                  setState(() => isDateVisibile = !isDateVisibile),
              theIcon: isDateVisibile
                  ? FontAwesomeIcons.solidCalendarXmark
                  : FontAwesomeIcons.solidCalendarCheck,
              theSize: 18,
              theSplashRadius: 18,
            ),
            const SizedBox(width: 2),
            customeIconButton(
              theOnPressed: () =>
                  setState(() => isReadingMode = !isReadingMode),
              theIcon: isReadingMode ? Icons.edit_note : Icons.height_sharp,
              theSize: 24,
              theSplashRadius: 18,
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: double.infinity,
          width: double.infinity,
          decoration: backgroundGradientCyan(),
          child: Badge(
            showBadge: isReadingMode ? false : true,
            // toAnimate: false,
            animationType: BadgeAnimationType.scale,
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
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 10, top: 0, bottom: 9),
                minLeadingWidth: 0,
                dense: true,
                leading: Container(
                  // color: Colors.red,
                  child: customeIconButton(
                      theOnPressed: () {
                        // TODO: do edit functionality
                      },
                      theIcon: Icons.edit),
                ),
                title:
                    customeText(theData: widget.theFileName, theFontSize: 20),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customeIconButton(
                        theOnPressed: () {},
                        theIcon: Icons.star_border,
                        theSize: 30,
                      ),
                      customeIconButton(
                        theOnPressed: () {},
                        theIcon: Icons.favorite_border,
                        theSize: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(
                  left: 5, right: 5, top: isReadingMode ? 5 : 40, bottom: 5),
              padding: EdgeInsets.only(top: isReadingMode ? 0 : 22.5),
              width: double.infinity,
              // height: 200,
              // alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey.shade300, width: 2.5),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(isReadingMode ? 5 : 34),
                    top: const Radius.circular(5)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: serviceFirestore.firestoreInstance
                            .collection("users2")
                            .doc(widget.theUser.uid)
                            .collection("subjects")
                            .doc(widget.theFileSubjectName)
                            .collection("files")
                            .doc(widget.theFileName)
                            .collection('messages')
                            .orderBy('createdAt')
                            .snapshots(),
                        builder: (context, snapshotMessages) {
                          if (snapshotMessages.connectionState ==
                              ConnectionState.waiting) {
                            return loadingIndicator();
                          } else if (snapshotMessages.hasError) {
                            return Text("err ${snapshotMessages.error}");
                          } else if (snapshotMessages.data == null ||
                              !snapshotMessages.hasData) {
                            return const Text(
                                'snapshotMessages is empty(StreamBuilder)');
                          }

                          // snapshotMessages.data!.docs.first;
                          debugPrint('44444messages');
                          debugPrint(
                              snapshotMessages.data!.docs.length.toString());
                          debugPrint(snapshotMessages.data.toString());

                          snapshotMessages.data?.docs;

                          final int messagesLength =
                              snapshotMessages.data!.docs.length;

                          if (messagesLength == 0) {
                            return customeText(theData: 'No messages found!');
                          } else {
                            return ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                color: Colors.transparent,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshotMessages.data!.docs.length,
                              itemBuilder: (context, theRecord) {
                                final QueryDocumentSnapshot<
                                        Map<String, dynamic>> theRecordItem =
                                    snapshotMessages.data!.docs[theRecord];
                                final theRecordItemMessage =
                                    theRecordItem.data()["message"];
                                final theMessageCreatedAt =
                                    theRecordItem.data()["createdAt"];
                                final theRecordItemReact =
                                    theRecordItem.data()["isReacted"];
                                final theRecordItemDocId =
                                    theRecordItem.data()["messageDocId"];

                                final String theRecordItemMessageAbbreviated =
                                    customeStringFunctions.customeSubString(
                                  theString: theRecordItemMessage,
                                  theResultLengthLimit: 5,
                                );

                                debugPrint(
                                    'ttttttt :: $theRecordItemMessageAbbreviated');

                                final theRecordFileCreatedAtConverted =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        theMessageCreatedAt);

                                var theRecordMessageCreatedAtVarListBoilerPlate =
                                    {
                                  'time': dateTimeOptimizer
                                      .dateTimeTwelveHourFormater(
                                          hourNumber:
                                              theRecordFileCreatedAtConverted
                                                  .hour,
                                          minuteNumber:
                                              theRecordFileCreatedAtConverted
                                                  .minute),
                                  // '${theRecordFileCreatedAtConverted.hour}:${theRecordFileCreatedAtConverted.minute}',
                                  'date':
                                      '${dateTimeOptimizer.dateTimeNumberToMonthName(monthNumber: theRecordFileCreatedAtConverted.month)}.${theRecordFileCreatedAtConverted.day}, ${theRecordFileCreatedAtConverted.year}',
                                  // 'date': theRecordFileCreatedAtConverted.month.toString(),
                                };
                                // debugPrint(
                                //     'test:: ${theRecordMessageCreatedAtVarListBoilerPlate['time']}');
                                // debugPrint(
                                //     'test:: ${theRecordMessageCreatedAtVarListBoilerPlate['date']}');

                                return Badge(
                                  animationType: BadgeAnimationType.fade,
                                  position:
                                      BadgePosition.topEnd(top: 17, end: 17),
                                  badgeColor: Colors.white,
                                  elevation: 0,
                                  badgeContent: SizedBox(
                                    height: 15,
                                    child: InkWell(
                                      onTap: () async =>
                                          await serviceFirestore.reactMessage(
                                        theMessageDocId: theRecordItemDocId,
                                        user: widget.theUser,
                                        theFileSubjectName:
                                            widget.theFileSubjectName,
                                        theMessageFileName: widget.theFileName,
                                        theIsReacted: !theRecordItemReact,
                                      ),
                                      highlightColor: Colors.transparent,
                                      child: customeIcon(
                                        theIcon: theRecordItemReact
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        theSize: 15,
                                        theColor: Colors.cyan.shade300,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 6),
                                        width: screenWidth - 50,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          // color: Colors.teal,
                                          border: Border.all(
                                              color: Colors.white, width: 0.5),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: ListTile(
                                          dense: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 10,
                                              right: 16,
                                              top: 10,
                                              bottom: 0),
                                          onLongPress: () {
                                            if (!isReadingMode) {
                                              showAnimatedDialog(
                                                barrierColor: Colors.black38,
                                                barrierDismissible: true,
                                                context: context,
                                                animationType:
                                                    DialogTransitionType
                                                        .sizeFade,
                                                curve: Curves.easeOut,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                duration: const Duration(
                                                    milliseconds: 800),
                                                builder: (_) {
                                                  return DialogDelete(
                                                    theTitle: "Message",
                                                    theName:
                                                        theRecordItemMessageAbbreviated,
                                                    theOnPressed: () async {
                                                      await serviceFirestore
                                                          .deleteMessage(
                                                        user: widget.theUser,
                                                        theFileSubjectName: widget
                                                            .theFileSubjectName,
                                                        theMessageFileName:
                                                            widget.theFileName,
                                                        theMessageDocId:
                                                            theRecordItemDocId,
                                                      )
                                                          .then((value) {
                                                        Get.back();
                                                        return Get.snackbar(
                                                            'Message caution',
                                                            'The messsage "$theRecordItemMessageAbbreviated" has been deleted successfully.');
                                                      });
                                                    },
                                                  );
                                                },
                                              );
                                            } else {
                                              Get.snackbar('Message caution',
                                                  'Messages may not be deleted, while you\'re in reading mode.');
                                            }
                                          },
                                          title: customeText(
                                              theData: theRecordItemMessage),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              customeText(
                                                theData: isDateVisibile
                                                    ? "\n${theRecordMessageCreatedAtVarListBoilerPlate['date']}"
                                                    : '',
                                                theTextAlign: TextAlign.end,
                                                theFontSize: 11,
                                              ),
                                              customeText(
                                                theData:
                                                    "\n${theRecordMessageCreatedAtVarListBoilerPlate['time']}",
                                                theTextAlign: TextAlign.start,
                                                theFontSize: 11,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  ),
                  isReadingMode
                      ? const SizedBox(
                          width: 0,
                          height: 0,
                        )
                      : (screenWidth > screenHeight)
                          ? const SizedBox(
                              width: 0,
                              height: 0,
                            )
                          : Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  height: 50,
                                  width: screenWidth - 65,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(22),
                                      right: Radius.circular(10),
                                    ),
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
                                  child: TextField(
                                    // focusNode: focusNode,
                                    controller: controllerMessage,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    cursorColor: Colors.cyan,
                                    // onSaved: (message) {},
                                    // maxLines: 1,
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.white70,
                                      hintText: "Message...",
                                      prefixIcon: customePaddingOnly(
                                        thePaddingLeft: 10,
                                        theChild: customeIconShaderMask(
                                          theIcon:
                                              Icons.emoji_emotions_outlined,
                                          theSize: 28,
                                        ),
                                      ),
                                      // suffixIcon: customePaddingOnly(
                                      //   thePaddingRight: 10,
                                      //   theChild: customeIconButton(
                                      //     theOnPressed: () => controllerMessage.clear(),
                                      //     theIcon: Icons.close,
                                      //     theSize: 22,
                                      //     theColor: Colors.grey.shade400,
                                      //   ),
                                      // ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 44,
                                  margin: const EdgeInsets.only(left: 3),
                                  // padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    // color: Colors.cyan,
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(24),
                                    ),
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
                                  child: customeIconButton(
                                    theOnPressed: () async {
                                      if (controllerMessage.text.isNotEmpty) {
                                        await serviceFirestore
                                            .createMessage(
                                              user: widget.theUser,
                                              theFileSubjectName:
                                                  widget.theFileSubjectName,
                                              theMessageFileName:
                                                  widget.theFileName,
                                              theMessage:
                                                  controllerMessage.text,
                                            )
                                            .then((value) =>
                                                controllerMessage.clear());
                                      } else {
                                        Get.snackbar(
                                          'Message caution',
                                          'Please enter a message.',
                                        );
                                      }
                                    },
                                    theIcon: Icons.send, // mic
                                    theColor: Colors.cyan.shade600,
                                    theSize: 27,
                                  ),
                                )
                              ],
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget messageInput() {
  //   return TextField(
  //     focusNode: focusNodeMessage,
  //     controller: controllerMessage,
  //     keyboardType: TextInputType.multiline,
  //     textInputAction: TextInputAction.newline,
  //     decoration: InputDecoration(
  //       hintText: 'hint...',
  //       // border: OutlineInputBorder(),
  //       suffixIcon: controllerMessage.text.isEmpty
  //           ? const SizedBox(
  //               width: 0,
  //               height: 0,
  //             )
  //           : customeIconButton(
  //               theOnPressed: () => controllerMessage.clear(),
  //               theIcon: Icons.close,
  //               theSize: 22,
  //               theColor: Colors.grey.shade400,
  //             ),
  //     ),
  //   );
  // }
}
