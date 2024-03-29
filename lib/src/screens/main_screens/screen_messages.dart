import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/provider/theme_provider.dart';
import 'package:grasp_app/src/reusable_codes/functions/date_time_functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/functions/custome_string_functions.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_delete.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';
import 'package:provider/provider.dart';

class ScreenMessages extends StatefulWidget {
  const ScreenMessages({
    super.key,
    required this.theUser,
    required this.theFileName,
    required this.theFileSubjectName,
    required this.theFileCreatedAt,
  });

  final User theUser;
  final String theFileName;
  final String theFileSubjectName;
  final String theFileCreatedAt;

  @override
  State<ScreenMessages> createState() => _ScreenMessagesState();
}

class _ScreenMessagesState extends State<ScreenMessages> {
  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final DateTimeOptimizer dateTimeOptimizer = DateTimeOptimizer();
  final CustomeStringFunctions customeStringFunctions =
      CustomeStringFunctions();

  final TextEditingController controllerMessage = TextEditingController();
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 1000000);

  final FocusNode focusNodeMessage = FocusNode();

  bool isDateVisibile = false;
  bool isReadingMode = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final theFileNameAbbreviated = customeStringFunctions.customeSubString(
        theString: widget.theFileName, theResultLengthLimit: 8);
    debugPrint('test width :: $screenWidth');
    debugPrint('test height:: $screenHeight');

    final String isReadingModeAppbarTitle =
        '${customeStringFunctions.customeSubString(theString: widget.theFileSubjectName, theResultLengthLimit: 4)}/ ${customeStringFunctions.customeSubString(theString: widget.theFileName, theResultLengthLimit: 4)}';

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          // backgroundColor: Colors.cyan.shade700,
          // centerTitle: true,
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
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 5),
          decoration: backgroundGradientCyan(context),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 5, right: 5, top: isReadingMode ? 5 : 40, bottom: 5),
                width: double.infinity,
                // height: 200,
                // alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 1.0,
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.grey.shade900.withOpacity(0.4)
                        // ? Colors.grey.withAlpha(100)
                        // ? Colors.black.withAlpha(100)
                        // : Colors.grey.shade300,
                        : Colors.white,
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(
                          isReadingMode || screenHeight < screenWidth ? 5 : 34),
                      top: const Radius.circular(5)),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: isReadingMode ? 0 : 18),
                      height: double.infinity,
                      width: double.infinity,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: serviceFirestore.firestoreInstance
                              .collection("users")
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
                              return customeText(
                                  theData: "err ${snapshotMessages.error}");
                            } else if (snapshotMessages.data == null ||
                                !snapshotMessages.hasData) {
                              return customeText(
                                  theData:
                                      'snapshotMessages is empty(StreamBuilder)');
                            }

                            // debugPrint('44444messages');
                            // debugPrint(
                            //     snapshotMessages.data!.docs.length.toString());
                            // debugPrint(snapshotMessages.data.toString());

                            snapshotMessages.data?.docs;

                            final int messagesLength =
                                snapshotMessages.data!.docs.length;

                            if (messagesLength == 0) {
                              return customeText(
                                theData: '\n\nNo messages found!',
                                theTextAlign: TextAlign.center,
                                theLetterSpacing: 1
                              );
                            } else {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.fromSwatch()
                                      .copyWith(
                                          secondary: Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkMode
                                              ? Colors.black12.withOpacity(0.9)
                                              : Theme.of(context)
                                                  .secondaryHeaderColor),
                                ),
                                child: ListView.separated(
                                  controller: scrollController,
                                  padding: EdgeInsets.only(
                                      top: isReadingMode ? 10 : 40,
                                      bottom: 10.0), // here
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    color: Colors.transparent,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshotMessages.data!.docs.length,
                                  itemBuilder: (context, theRecord) {
                                    final QueryDocumentSnapshot<
                                            Map<String, dynamic>>
                                        theRecordItem =
                                        snapshotMessages.data!.docs[theRecord];
                                    final theRecordItemMessage =
                                        theRecordItem.data()["message"];
                                    final theMessageCreatedAt =
                                        theRecordItem.data()["createdAt"];
                                    final theRecordItemReact =
                                        theRecordItem.data()["isReacted"];
                                    final theRecordItemDocId =
                                        theRecordItem.data()["messageDocId"];

                                    final String
                                        theRecordItemMessageAbbreviated =
                                        customeStringFunctions.customeSubString(
                                      theString: theRecordItemMessage,
                                      theResultLengthLimit: 5,
                                    );

                                    // debugPrint(
                                    //     'ttttttt :: $theRecordItemMessageAbbreviated');

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
                                      'date':
                                          '${dateTimeOptimizer.dateTimeNumberToMonthName(monthNumber: theRecordFileCreatedAtConverted.month)}.${theRecordFileCreatedAtConverted.day}, ${theRecordFileCreatedAtConverted.year}',
                                    };
                                    return Badge(
                                      animationType: BadgeAnimationType.fade,
                                      position: BadgePosition.topEnd(
                                          top: 17, end: 17),
                                      // reaction color
                                      badgeColor:
                                          Provider.of<ThemeProvider>(context)
                                                  .isDarkMode
                                              ? Colors.black87
                                              : Colors.grey.shade100,
                                      // reaction color
                                      borderSide: BorderSide(
                                          color: Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkMode
                                              ? Colors.grey.shade600
                                              : Colors.white,
                                          width: 0.5),
                                      elevation: 0,
                                      badgeContent: SizedBox(
                                        height: 15,
                                        child: InkWell(
                                          onTap: () async =>
                                              await serviceFirestore
                                                  .reactMessage(
                                            theMessageDocId: theRecordItemDocId,
                                            user: widget.theUser,
                                            theFileSubjectName:
                                                widget.theFileSubjectName,
                                            theMessageFileName:
                                                widget.theFileName,
                                            theIsReacted: !theRecordItemReact,
                                          ),
                                          highlightColor: Colors.transparent,
                                          child: customeIcon(
                                            theIcon: theRecordItemReact
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            theSize: 15,
                                            // reaction color
                                            theColor:
                                                Provider.of<ThemeProvider>(
                                                            context)
                                                        .isDarkMode
                                                    ? Colors.grey.shade600
                                                    // ? Colors.black87
                                                    : Colors.cyan,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 6),
                                                width: screenWidth - 50,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  color:
                                                      Provider.of<ThemeProvider>(
                                                                  context)
                                                              .isDarkMode
                                                          ? Colors.black38
                                                          : Colors.white
                                                              .withOpacity(0.9),
                                                  // border: Border.all(
                                                  //     color: Colors.cyan, width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Provider.of<
                                                                    ThemeProvider>(
                                                                context)
                                                            .isDarkMode
                                                        ? Radius.circular(8)
                                                        : Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                child: ListTile(
                                                  dense: true,
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 16,
                                                          top: 10,
                                                          bottom: 0),
                                                  onLongPress: () {
                                                    if (!isReadingMode) {
                                                      showAnimatedDialog(
                                                        barrierColor:
                                                            Colors.black38,
                                                        barrierDismissible:
                                                            true,
                                                        context: context,
                                                        animationType:
                                                            DialogTransitionType
                                                                .sizeFade,
                                                        curve: Curves.easeOut,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    800),
                                                        builder: (_) {
                                                          return DialogDelete(
                                                            theTitle: "Message",
                                                            theName:
                                                                theRecordItemMessageAbbreviated,
                                                            theOnPressed:
                                                                () async {
                                                              await serviceFirestore
                                                                  .deleteMessage(
                                                                user: widget
                                                                    .theUser,
                                                                theFileSubjectName:
                                                                    widget
                                                                        .theFileSubjectName,
                                                                theMessageFileName:
                                                                    widget
                                                                        .theFileName,
                                                                theMessageDocId:
                                                                    theRecordItemDocId,
                                                              )
                                                                  .then(
                                                                      (value) {
                                                                Get.back();
                                                                return customeSnackbar(
                                                                  theTitle:
                                                                      'Message caution',
                                                                  theMessage:
                                                                      'The messsage "$theRecordItemMessageAbbreviated" has been deleted successfully.',
                                                                );
                                                              });
                                                            },
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      customeSnackbar(
                                                        theTitle:
                                                            'Message caution',
                                                        theMessage:
                                                            'Messages may not be deleted, while you\'re in reading mode.',
                                                      );
                                                    }
                                                  },
                                                  title: customeText(
                                                      theData:
                                                          theRecordItemMessage),
                                                  // SelectableText(theRecordItemMessage),
                                                  subtitle: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      customeText(
                                                        theData: isDateVisibile
                                                            ? "\n${theRecordMessageCreatedAtVarListBoilerPlate['date']}"
                                                            : '',
                                                        theTextAlign:
                                                            TextAlign.end,
                                                        theFontSize: 11,
                                                      ),
                                                      customeText(
                                                        theData:
                                                            "\n${theRecordMessageCreatedAtVarListBoilerPlate['time']}",
                                                        theTextAlign:
                                                            TextAlign.start,
                                                        theFontSize: 11,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: theRecord ==
                                                    (snapshotMessages
                                                            .data!.docs.length -
                                                        1)
                                                ? 60
                                                : 0,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
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
                            : Positioned(
                                bottom: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 2),
                                  // padding: EdgeInsets.only(right: 1),
                                  decoration: BoxDecoration(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.grey.shade800
                                        : Colors.white30,
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(22),
                                      right: Radius.circular(24),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 2),
                                        height: 50,
                                        width: screenWidth - 62,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                            left: Radius.circular(22),
                                            right: Radius.circular(10),
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? [
                                                    Colors.black.withAlpha(100),
                                                    Colors.black.withAlpha(100),
                                                    // Colors.black87,
                                                    // Colors.black87,
                                                    // Colors.black.withGreen(100),
                                                    // Colors.black.withGreen(0),
                                                  ]
                                                : [
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
                                          textInputAction:
                                              TextInputAction.newline,
                                          cursorColor: Colors.white,
                                          // onSaved: (message) {},
                                          // maxLines: 1,
                                          decoration: InputDecoration(
                                            // filled: true,
                                            // fillColor: Colors.white70,
                                            hintText: "Aa",
                                            prefixIcon: customePaddingOnly(
                                              thePaddingLeft: 10,
                                              theChild: customeIconShaderMask(
                                                theIcon: Icons
                                                    .emoji_emotions_outlined,
                                                theSize: 28,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 46,
                                        margin: const EdgeInsets.only(left: 3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                            left: Radius.circular(10),
                                            right: Radius.circular(24),
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? [
                                                    Colors.black.withAlpha(100),
                                                    Colors.black.withAlpha(100),
                                                  ]
                                                : [
                                                    Colors.grey.shade300,
                                                    Colors.grey.shade200,
                                                    Colors.white,
                                                  ],
                                          ),
                                        ),
                                        child: customeIconButton(
                                          theOnPressed: () async {
                                            if (controllerMessage
                                                .text.isNotEmpty) {
                                              await serviceFirestore
                                                  .createMessage(
                                                    user: widget.theUser,
                                                    theFileSubjectName: widget
                                                        .theFileSubjectName,
                                                    theMessageFileName:
                                                        widget.theFileName,
                                                    theMessage:
                                                        controllerMessage.text,
                                                  )
                                                  .then((value) =>
                                                      controllerMessage
                                                          .clear());
                                            } else {
                                              customeSnackbar(
                                                theTitle: 'Message caution',
                                                theMessage:
                                                    'Please enter a message.',
                                              );
                                            }
                                          },
                                          theIcon: Icons.send, // mic
                                          theColor: Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkMode
                                              ? Colors.white70
                                              : Colors.cyan.shade600,
                                          theSize: 27,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
              isReadingMode
                  ? SizedBox()
                  : Positioned(
                      left: 10,
                      top: 15,
                      child: Container(
                        height: 50,
                        width: screenWidth - 20,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? [
                                          Colors.grey.shade900,
                                          Colors.grey.shade900,
                                        ]
                                      : [
                                          Colors.grey.shade300,
                                          Colors.grey.shade100,
                                          Colors.white,
                                        ],
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: customeIconButton(
                                theOnPressed: () async {
                                  debugPrint('kkkkkkkkkkkkkkk1111 star');
                                  debugPrint('added to star');
                                  await serviceFirestore
                                      .favStarFile(
                                        user: widget.theUser,
                                        theFileSubjectName:
                                            widget.theFileSubjectName,
                                        theFileName: widget.theFileName,
                                        theFileCreatedAt:
                                            widget.theFileCreatedAt,
                                        isFileFaved: false,
                                        isFileStared: true,
                                      )
                                      .then((value) =>
                                          debugPrint('added to added to star'));
                                  customeSnackbar(
                                    theTitle: 'Message caution',
                                    theMessage:
                                        'The grasp "$theFileNameAbbreviated" added to your Stars.',
                                  );
                                },
                                theIcon: Icons.star_border,
                                theSize: 30,
                              ),
                            ),
                            InkWell(
                              onLongPress: () async {
                                // debugPrint('added to star');
                                // await serviceFirestore
                                //     .favStarFile(
                                //       user: widget.theUser,
                                //       theFileSubjectName: widget.theFileSubjectName,
                                //       theFileName: widget.theFileName,
                                //       theFileCreatedAt: widget.theFileCreatedAt,
                                //       isFileFaved: false,
                                //       isFileStared: true,
                                //     )
                                //     .then((value) =>
                                //         debugPrint('added to added to star'));
                                // customeSnackbar(
                                //   theTitle: 'Message caution',
                                //   theMessage:
                                //       'The grasp "$theFileNameAbbreviated" added to your Stars.',
                                // );
                              },
                              onTap: () async {
                                // debugPrint('added to fav');
                                // await serviceFirestore
                                //     .favStarFile(
                                //       user: widget.theUser,
                                //       theFileSubjectName: widget.theFileSubjectName,
                                //       theFileName: widget.theFileName,
                                //       theFileCreatedAt: widget.theFileCreatedAt,
                                //       isFileFaved: true,
                                //       isFileStared: false,
                                //     )
                                //     .then((value) =>
                                //         debugPrint('added to added to fav'));
                                // customeSnackbar(
                                //   theTitle: 'Message caution',
                                //   theMessage:
                                //       'The grasp "$theFileNameAbbreviated" added to your Favorites.',
                                // );
                              },
                              child: customeText(
                                  theData: widget.theFileName,
                                  theFontSize: 20,
                                  theTextAlign: TextAlign.center),
                            ),
                            Expanded(
                              flex: 1,
                              child: customeIconButton(
                                theOnPressed: () async {
                                  debugPrint('added to fav');
                                  await serviceFirestore
                                      .favStarFile(
                                        user: widget.theUser,
                                        theFileSubjectName:
                                            widget.theFileSubjectName,
                                        theFileName: widget.theFileName,
                                        theFileCreatedAt:
                                            widget.theFileCreatedAt,
                                        isFileFaved: true,
                                        isFileStared: false,
                                      )
                                      .then((value) =>
                                          debugPrint('added to added to fav'));
                                  customeSnackbar(
                                    theTitle: 'Message caution',
                                    theMessage:
                                        'The grasp "$theFileNameAbbreviated" added to your Favorites.',
                                  );
                                },
                                theIcon: Icons.favorite_border,
                                theSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
