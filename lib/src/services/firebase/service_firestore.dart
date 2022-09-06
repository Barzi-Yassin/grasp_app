// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grasp_app/src/models/grasp_user_model.dart';

class ServiceFirestore {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<GraspUser> addUserInfoAfterAuthToDB({
    required User user,
    String? theName,
    String? theImageUrl,
  }) async {
    // ignore: unused_local_variable
    GraspUser graspUser = GraspUser(
      userInAppId: 1,
      uid: user.uid,
      email: user.email!,
      createdAt: DateTime.now(),
      name: theName ?? "not inputed yet!",
      imageUrl: theImageUrl ?? "not inputed yet!",
    );

    await firestoreInstance.collection("users").doc(user.uid).set(graspUser.toMap());
    return graspUser;
  }
}