import 'dart:io';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/services/firebase/service_storage.dart';
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
// final ServiceAuth serviceAuth = ServiceAuth();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // image picker
  File? imageSelected;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => imageSelected = imageTemp);
    } on PlatformException catch (e) {
      // this exception occur when user has denied the app to access gallery
      debugPrint('failed to pick image: $e');
    }
  }
  // end of image picker

  ServiceStorage serviceStorage = ServiceStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            customeTextAuthHeader(theData: '• profile •'),
            const SizedBox(height: 100),
            const SizedBox(height: 100),
            SizedBox(
              height: 210,
              width: 210,
              child: InkWell(
                onTap: () async => await pickImage(),
                child: Badge(
                  padding: const EdgeInsets.all(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade400,
                      Colors.cyan.shade200,
                      // Colors.white,
                      // Colors.white,
                    ],
                  ),
                  borderSide: const BorderSide(color: Colors.white60, width: 1),
                  elevation: 0,
                  position: BadgePosition.topStart(start: 10, top: 12),
                  badgeColor: Colors.cyan.shade200,
                  badgeContent: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 25.0,
                    color: Colors.white70,
                    // shadows: [
                    //   BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                    //   // BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   // BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   BoxShadow(blurRadius: 10.0, color: Colors.grey),
                    //   // BoxShadow(blurRadius: 10.0, color: Colors.cyan),
                    // ],
                  ),
                  showBadge: true,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white60, width: 2.0),
                    ),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: imageSelected != null
                          ? FileImage(imageSelected!) as ImageProvider
                          : const AssetImage("assets/images/person.jpg"),
                      // backgroundImage: isImagePicked == !true
                      //     ? const AssetImage("assets/images/person.jpg")
                      //     : const AssetImage('assets/images/3.jpeg'),
                      radius: 100,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: customeText(theData: 'SKIP'),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    if (imageSelected != null) {
                      serviceStorage.uploadImage(
                        imageSelected!,
                        theUser: widget.theUser,
                      );
                      debugPrint('no image selected');
                    }
                  },
                  child: customeText(theData: 'SAVE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
