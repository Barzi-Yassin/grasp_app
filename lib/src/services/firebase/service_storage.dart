import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ServiceStorage {
  // Create a storage reference from our app

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;  

  // StorageReference storageRef = storage.getReference();

  uploadImage(File file, {required User theUser} ) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("users/${theUser.uid}/profileImage");
    // final imagesRef = storageRef.child("users/profileimage");

    String? imgDlRef;

    debugPrint('storageRef: $storageRef');
    debugPrint('imagesRef: $imagesRef');

    imagesRef.putFile(file).snapshotEvents.listen((taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // setState(() => isLoading = false);
          debugPrint('TaskState:: is <running>');
          break;
        case TaskState.paused:
          debugPrint('TaskState:: is <paused>');
          // setState(() => isLoading = false);
          break;
        case TaskState.success:
          imgDlRef = await imagesRef.getDownloadURL();
          debugPrint('TaskState:: is <success> || download url: $imgDlRef');
          break;
        case TaskState.canceled:
          debugPrint('TaskState:: is <canceled>');
          // setState(() => isLoading = false);
          break;
        case TaskState.error:
          debugPrint('TaskState:: is <error>');
          // setState(() => isLoading = false);
          break;
      }
    });
  }
}
