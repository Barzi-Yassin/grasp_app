import 'dart:io';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/screens/main_screens/screen_subjects.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ScreenSetUserprofileImage extends StatefulWidget {
  const ScreenSetUserprofileImage({
    Key? key,
    required this.theControllerUsername,
    required this.theUser,
  }) : super(key: key);

  final String theControllerUsername;
  final User theUser;

  @override
  State<ScreenSetUserprofileImage> createState() =>
      _ScreenSetUserprofileImageState();
}

class _ScreenSetUserprofileImageState extends State<ScreenSetUserprofileImage> {
  final ServiceFirestore serviceFirestore = ServiceFirestore();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  File? imageSelected;
  String? imageDownloadLink;
  bool isLoading = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.grey.shade400,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: backgroundGradientCyan(context),
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
                    SizedBox(height: screenHeight * 0.15),
                    customeTextGraspHeader(
                        theData: '• grasp •', theFontSize: 50),
                    SizedBox(height: screenHeight * 0.06),
                    customeTextAuthHeader(theData: 'Profile', theFontSize: 30),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      height: 335,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 210,
                            width: 210,
                            child: InkWell(
                              onTap: () async => await pickImage(
                                  theImageSource: ImageSource.gallery),
                              onLongPress: () async => await pickImage(
                                  theImageSource: ImageSource.camera),
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
                                borderSide: const BorderSide(
                                    color: Colors.white60, width: 1),
                                elevation: 0,
                                position:
                                    BadgePosition.topStart(start: 10, top: 12),
                                badgeColor: Colors.cyan.shade200,
                                badgeContent: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 25.0,
                                  color: Colors.black,
                                  shadows: [
                                    BoxShadow(
                                        blurRadius: 8.0, color: Colors.white),
                                    BoxShadow(
                                        blurRadius: 8.0, color: Colors.grey),
                                    BoxShadow(
                                        blurRadius: 1.0, color: Colors.red),
                                  ],
                                ),
                                showBadge: true,
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white60, width: 2.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    backgroundImage: imageSelected != null
                                        ? FileImage(imageSelected!)
                                            as ImageProvider
                                        : const AssetImage(
                                            "assets/images/default.jpg"),
                                    radius: 100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => isLoading = true);
                                  if (widget.theControllerUsername.isNotEmpty) {
                                    serviceFirestore
                                        .addUserInfoAfterAuthToDB(
                                      user: widget.theUser,
                                      theName: widget.theControllerUsername,
                                    )
                                        .then((_) {
                                      setState(() => isLoading = false);
                                      Get.offAll(ScreenSubjects(
                                          theUser: widget.theUser));
                                    });
                                  } else {
                                    serviceFirestore
                                        .addUserInfoAfterAuthToDB(
                                            user: widget.theUser)
                                        .then((_) {
                                      setState(() => isLoading = false);
                                      Get.offAll(ScreenSubjects(
                                          theUser: widget.theUser));
                                    });
                                  }
                                },
                                style: customeButtonStyle(),
                                child: customeText(
                                  theData: 'SKIP',
                                  theLetterSpacing: 1,
                                  theFontSize: 17,
                                  theFontWeight: FontWeight.w600,
                                  theFontFamily: 'MavenPro',
                                ),
                              ),
                              const SizedBox(width: 50),
                              ElevatedButton(
                                onPressed: () async {
                                  if (imageSelected != null) {
                                    setState(() => isLoading = true);
                                    uploadImage(
                                      imageSelected!,
                                      theUser: widget.theUser,
                                    ).then((_) async {
                                      if (mounted) {
                                        setState(() => isLoading = false);
                                      }
                                      Get.offAll(
                                        ScreenSubjects(theUser: widget.theUser),
                                      );
                                    });
                                  } else {
                                    debugPrint('no image selected');
                                    if (mounted) {
                                      setState(() => isLoading = false);
                                    }
                                    customeSnackbar(
                                      theTitle: 'Image Caution',
                                      theMessage:
                                          'No image selected yet! \nSelect an image to save, or skip it for now.',
                                    );
                                  }
                                },
                                style: customeButtonStyle(),
                                child: customeText(
                                  theData: 'SAVE',
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
    final imagesRef = storageRef.child("users/${theUser.email}/profileImage");
    // final imagesRef = storageRef.child("users/profileimage");

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
          serviceFirestore.addUserInfoAfterAuthToDB(
            user: widget.theUser,
            theName: widget.theControllerUsername,
            theImageUrl: imgDlRef.toString(),
          );

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
