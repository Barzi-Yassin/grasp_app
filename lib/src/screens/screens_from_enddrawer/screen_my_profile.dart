import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ScreenMyProfile extends StatefulWidget {
  const ScreenMyProfile({
    Key? key,
    this.theUser,
    required this.theImgUrl,
    required this.theUsername,
  }) : super(key: key);
  final User? theUser;
  final String theImgUrl;
  final String theUsername;

  @override
  State<ScreenMyProfile> createState() => _ScreenMyProfileState();
}

class _ScreenMyProfileState extends State<ScreenMyProfile> {
  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final TextEditingController controllerUsername = TextEditingController();

  File? imageSelected;
  String? imageDownloadLink;
  bool isLoading = false;
  bool isUsernameChanging = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      endDrawer: SafeArea(
        child: EndDrawer(theUser: widget.theUser),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        leading: functionArrowbackIconButton(context),
        title: const Text('My Profile'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: backgroundGradientCyan(),
        child: isLoading == true
            ? loadingIndicator()
            : SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                child: Column(
                  //  TODO: it causse render flex error while no loading
                  children: [
                    // const SizedBox(height: 100),
                    // customeTextAuthHeader(theData: '• profile •'),
                    // // customeText(
                    // //     theData: widget.theControllerUsername.isNotEmpty
                    // //         ? widget.theControllerUsername
                    // //         : 'nulllll',
                    // //     theColor: Colors.green,
                    // //     theFontSize: 20), //  TODO: temporary
                    // customeText(
                    //   theData: widget.theUser!.email.toString(),
                    // ), //  TODO: temporary
                    // customeText(
                    //   theData: widget.theImgUrl,
                    // ), //  TODO: temporary

                    const SizedBox(height: 60),
                    SizedBox(
                      height: 210,
                      width: 210,
                      child: InkWell(
                        onTap: () async => await pickImage(
                            theImageSource: ImageSource.gallery),
                        onLongPress: () async =>
                            await pickImage(theImageSource: ImageSource.camera),
                        child: Badge(
                          padding: const EdgeInsets.all(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey.shade400,
                              Colors.cyan.shade200,
                            ],
                          ),
                          borderSide:
                              const BorderSide(color: Colors.white60, width: 1),
                          elevation: 0,
                          position: BadgePosition.topStart(start: 10, top: 12),
                          badgeColor: Colors.cyan.shade200,
                          badgeContent: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 25.0,
                            color: Colors.black,
                            shadows: [
                              BoxShadow(blurRadius: 8.0, color: Colors.white),
                              BoxShadow(blurRadius: 8.0, color: Colors.grey),
                              BoxShadow(blurRadius: 1.0, color: Colors.red),
                            ],
                          ),
                          showBadge: true,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white60, width: 2.0),
                            ),
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundImage: imageSelected != null
                                  ? FileImage(imageSelected!)
                                  : widget.theImgUrl.length > 20
                                      ? CachedNetworkImageProvider(
                                          widget.theImgUrl,
                                        )
                                      : const AssetImage(
                                              'assets/images/default.jpg')
                                          as ImageProvider,
                              radius: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      height: 160,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => setState(
                                () => isUsernameChanging = !isUsernameChanging),
                            child: customeText(
                                theData: widget.theUsername,
                                theFontSize: 25,
                                theColor: Colors.brown,
                                theFontWeight: FontWeight.w500,
                                theLetterSpacing: 1,
                                theWordSpacing: 1),
                          ),
                          isUsernameChanging
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 20),
                                  // color: Colors.brown.shade100,
                                  alignment: Alignment.center,
                                  // height: 100,
                                  child: TextField(
                                    controller: controllerUsername,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    cursorColor: Colors.cyan,
                                    // onSaved: (message) {},
                                    // maxLines: 1,
                                    maxLength: 15,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white70,
                                      hintText: "new username",
                                      // suffixIcon: customePaddingOnly(
                                      //   thePaddingRight: 10,
                                      //   theChild: customeIconButton(
                                      //     theOnPressed: () => controllerMessage.clear(),
                                      //     theIcon: Icons.close,
                                      //     theSize: 22,
                                      //     theColor: Colors.grey.shade400,
                                      //   ),
                                      // ),
                                      border: OutlineInputBorder(
                                          gapPadding: 110,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                )
                              : const SizedBox(width: 0, height: 0),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {
                        //     setState(() => isLoading = true);
                        //     if (controllerUsername.text.isNotEmpty) {
                        //       serviceFirestore
                        //           .addUserInfoAfterAuthToDB(
                        //         user: widget.theUser!,
                        //         theName: controllerUsername.text,
                        //       )
                        //           .then((_) {
                        //         setState(() => isLoading = false);
                        //         // Get.to(ScreenSubjects(theUser: widget.theUser));
                        //       });
                        //     } else {
                        //       serviceFirestore
                        //           .addUserInfoAfterAuthToDB(
                        //               user: widget.theUser!)
                        //           .then((_) {
                        //         setState(() => isLoading = false);
                        //         // Get.offAll(
                        //         //     ScreenSubjects(theUser: widget.theUser));
                        //       });
                        //     }
                        //   },
                        //   child: customeText(theData: 'SKIP'),
                        // ),
                        // const SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () async {
                            if (imageSelected != null) {
                              setState(() => isLoading = true);
                              uploadImage(
                                imageSelected!,
                                theUser: widget.theUser!,
                              ).then((_) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });
                            } else if (controllerUsername.text.isNotEmpty &&
                                controllerUsername.text != widget.theUsername) {
                              String temp = controllerUsername.text;
                              temp = temp.replaceAll(" ", "");

                              if (temp.isNotEmpty) {
                                await serviceFirestore
                                    .addUserInfoAfterAuthToDB(
                                  user: widget.theUser!,
                                  theImageUrl: widget.theImgUrl,
                                  theName: controllerUsername.text,
                                )
                                    .then(
                                  (_) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                );
                              } else {
                                customeSnackbar(
                                  theTitle: 'Username caution',
                                  theMessage: 'Try not to input spaces only!',
                                );
                                return;
                              }

                              if (mounted) {
                                setState(() => isLoading = false);
                              }
                              debugPrint('Username updated.');
                              customeSnackbar(
                                theTitle: 'Image Caution',
                                theMessage: 'Username updated',
                              );
                            } else {
                              debugPrint('Nothing updated!');
                              customeSnackbar(
                                theTitle: 'Profile Caution',
                                theMessage: 'Nothing updated!',
                              );
                            }
                          },
                          style: customeButtonStyle(),
                          child: customeText(
                            theData: 'UPDATE',
                            theLetterSpacing: 1,
                            theFontSize: 17,
                            theFontWeight: FontWeight.w600,
                            theFontFamily: 'MavenPro',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // image picker
  Future pickImage({required ImageSource theImageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: theImageSource);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => imageSelected = imageTemp);
    } on PlatformException catch (e) {
      // this exception occur when user has denied the app to access gallery
      debugPrint('failed to pick image: $e');
    }
  }
  // end of image picker

  // Upload image to firebase storage
  uploadImage(File file, {required User theUser}) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("users2/${theUser.email}/profileImage");
    // final imagesRef = storageRef.child("users2/profileimage");

    String? imgDlRef;

    debugPrint('storageRef: $storageRef');
    debugPrint('imagesRef: $imagesRef');

    imagesRef.putFile(file).snapshotEvents.listen((taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // setState(() => isLoading = true);
          debugPrint('TaskState:: is <running>');
          break;
        case TaskState.paused:
          debugPrint('TaskState:: is <paused>');
          // setState(() => isLoading = false);
          break;
        case TaskState.success:
          imgDlRef = await imagesRef.getDownloadURL();
          if (imgDlRef != widget.theImgUrl) {
            serviceFirestore
                .addUserInfoAfterAuthToDB(
              user: widget.theUser!,
              theImageUrl: imgDlRef.toString(),
              theName: controllerUsername.text.isNotEmpty &&
                      controllerUsername.text != widget.theUsername
                  ? controllerUsername.text
                  : widget.theUsername,
            )
                .then(
              (_) async {
                if (mounted) {
                  setState(() => isLoading = false);
                }
                if (controllerUsername.text.isNotEmpty &&
                    controllerUsername.text != widget.theUsername) {
                  debugPrint('Image and username updated successfully.');
                  customeSnackbar(
                    theTitle: 'Profile Caution',
                    theMessage: 'Image and username updated successfully.',
                  );
                } else {
                  debugPrint('Image updated successfully.');
                  customeSnackbar(
                    theTitle: 'Profile Caution',
                    theMessage: 'Image updated successfully.',
                  );
                }
                imageSelected = null;
                // Get.back();
              },
            );
          } else {
            debugPrint('Nothing updated!');
            customeSnackbar(
              theTitle: 'Profile Caution',
              theMessage: 'Nothing updated!',
            );
          }

          // setState(() {
          //   imageDownloadLink = imgDlRef;
          //   // isLoading = false;
          // });
          debugPrint('TaskState:: is <success> || download url: $imgDlRef');
          break;
        case TaskState.canceled:
          debugPrint('TaskState:: is <canceled>');
          // setState(() => isLoading = false);
          break;
        case TaskState.error:
          debugPrint('TaskState:: is <error> ${TaskState.error}');
          // setState(() => isLoading = false);
          break;
      }
    });
  }
  // end Upload image to firebase storage

}
