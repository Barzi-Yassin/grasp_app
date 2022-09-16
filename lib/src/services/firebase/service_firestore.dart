// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/models/grasp_file_model.dart';
import 'package:grasp_app/src/models/grasp_message_model.dart';
import 'package:grasp_app/src/models/secondary_models/grasp_message_reaction_model.dart';
import 'package:grasp_app/src/models/grasp_subject_model.dart';
import 'package:grasp_app/src/models/grasp_user_model.dart';
import 'package:grasp_app/src/models/secondary_models/grasp_subject_update_model.dart';

class ServiceFirestore {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  // add user credential to db
  Future<GraspUserModel> addUserToDB({required User user}) async {
    GraspUserModel graspUserModel = GraspUserModel(
      userInAppId: 1,
      uid: user.uid,
      email: user.email!,
      createdAt: DateTime.now(),
    );

    await firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .set(graspUserModel.toMap());
    return graspUserModel;
  }

  // add user info to db
  Future<GraspUserModel> addUserInfoAfterAuthToDB({
    required User user,
    String? theName,
    String? theImageUrl,
  }) async {
    GraspUserModel graspUserModel = GraspUserModel(
      userInAppId: 2,
      uid: user.uid,
      email: user.email!,
      createdAt: DateTime.now(),
      name: theName ?? "Username",
      imageUrl: theImageUrl ?? "not inputed yet!",
    );

    await firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .update(graspUserModel.toMap());
    return graspUserModel;
  }

  // create subject
  Future<GraspSubjectModel> createSubject({
    required User user,
    required String theSubjectName,
  }) async {
    GraspSubjectModel graspSubjectModel = GraspSubjectModel(
      uid: user.uid,
      subjectName: theSubjectName,
      subjectItemsNumber: "0",
      subjectUpdateAt: DateTime.now(),
      subjectCreatedAt: DateTime.now(),
    );

    await firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection('subjects')
        .doc(theSubjectName)
        .set(graspSubjectModel.toMap());
    return graspSubjectModel;
  }

  // delete subject
  Future deleteSubject({
    required User user,
    required String theSubjectName,
  }) async {
    final DocumentReference<Map<String, dynamic>> docSubject = firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection("subjects")
        .doc(theSubjectName);

    await docSubject.delete();
    return;
  }

  // update subject
  Future<GraspSubjectUpdateModel> updateSubject({
    required User user,
    required String theSubjectName,
    required String theSubjectItemsNumber,
  }) async {
    GraspSubjectUpdateModel graspSubjectUpdateModel = GraspSubjectUpdateModel(
      subjectItemsNumber: theSubjectItemsNumber,
      subjectUpdateAt: DateTime.now(),
    );

    await firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection('subjects')
        .doc(theSubjectName)
        .update(graspSubjectUpdateModel.toMap());
    return graspSubjectUpdateModel;
  }

// create file
  Future<GraspFileModel> createFile({
    required User user,
    required String theFileSubjectName,
    required String theFileName,
    bool? theIsFileFaved,
    bool? theIsFileStared,
    bool? theIsFileUpdated,
  }) async {
    GraspFileModel graspFileModel = GraspFileModel(
      uid: user.uid,
      fileSubjectName: theFileSubjectName,
      fileName: theFileName,
      fileCreatedAt: DateTime.now(),
      fileUpdatedAt: DateTime.now(),
      isFileFaved: theIsFileFaved,
      isFileStared: theIsFileStared,
    );

    await firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection("subjects")
        .doc(theFileSubjectName)
        .collection("files")
        .doc(theFileName)
        .set(graspFileModel.toMap());
    return graspFileModel;
  }

// delete file ::::::  // TODO: clean the message deletion process !!!
  Future deleteFile({
    required User user,
    required String theFileSubjectName,
    required String theFileName,
  }) async {
    final DocumentReference<Map<String, dynamic>> docFile = firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection("subjects")
        .doc(theFileSubjectName)
        .collection("files")
        .doc(theFileName);

    docMessageDeleteFunction({required String theDocMessageId}) async {
      final DocumentReference<Map<String, dynamic>> docMessage =
          firestoreInstance
              .collection("users2")
              .doc(user.uid)
              .collection("subjects")
              .doc(theFileSubjectName)
              .collection("files")
              .doc(theFileName)
              .collection("messages")
              .doc(theDocMessageId);

      await docMessage.delete();
    }

    final Stream<QuerySnapshot<Map<String, dynamic>>> theStream =
        firestoreInstance
            .collection("users2")
            .doc(user.uid)
            .collection("subjects")
            .doc(theFileSubjectName)
            .collection("files")
            .doc(theFileName)
            .collection('messages')
            .snapshots();

    theStream.forEach((snapshotMessage) {
      debugPrint('hellllllo :: ${snapshotMessage.docs.length}');
      debugPrint('hellllllo :: $snapshotMessage');
      snapshotMessage.docs.forEach((snapshotMessage) async {
        final messageDocid = snapshotMessage.data()["messageDocId"];
        debugPrint('hellllllo messageDocid ==== $messageDocid');
        docMessageDeleteFunction(theDocMessageId: messageDocid);
      });
    });

    await docFile.delete();
    return;
  }

  //  get subject items length
  // Future<String> getSubjectItemsLength(
  //     {required User user, required String theSubjectName}) async {
  //   final QuerySnapshot<Map<String, dynamic>> theSubjectFilesStream =
  //       await firestoreInstance
  //           .collection("users2")
  //           .doc(user.uid)
  //           .collection("subjects")
  //           .doc(theSubjectName)
  //           .collection("files")
  //           .get();

  //   final String result = theSubjectFilesStream.docs.length.toString();
  //   debugPrint('fffffffff :: $result');

  //   return result;
  // }

  // in destination
  /*
  serviceFirestore
    .getSubjectItemsLength(
        user: widget.theUser,
        theSubjectName: widget.theFileSubjectName)
    .then((String value) {
      setState(() {
        test = value; // test is a local string variable 
      });
      debugPrint('testtttt :: $test');
    });
    // but icauses infinite reaload
*/

// create message
  Future<GraspMessageModel> createMessage({
    required User user,
    required String theFileSubjectName,
    required String theMessageFileName,
    required String theMessage,
  }) async {
    final docMessage = firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection("subjects")
        .doc(theFileSubjectName)
        .collection("files")
        .doc(theMessageFileName)
        .collection("messages")
        .doc();

    GraspMessageModel graspMessageModel = GraspMessageModel(
      messageDocId: docMessage.id,
      message: theMessage,
      messageFileName: theMessageFileName,
      isReacted: false,
      createdAt: DateTime.now(),
    );

    await docMessage.set(graspMessageModel.toMap());
    return graspMessageModel;
  }

  // react a message
  Future<GraspMessageReactionModel> reactMessage({
    required User user,
    required String theFileSubjectName,
    required String theMessageFileName,
    required String theMessageDocId,
    required bool theIsReacted,
  }) async {
    final docMessage = firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection("subjects")
        .doc(theFileSubjectName)
        .collection("files")
        .doc(theMessageFileName)
        .collection("messages")
        .doc(theMessageDocId);

    GraspMessageReactionModel graspMessageReactionModel =
        GraspMessageReactionModel(
      isReacted: theIsReacted,
    );

    await docMessage.update(graspMessageReactionModel.toMap());
    return graspMessageReactionModel;
  }

  // delete a message
  Future deleteMessage({
    required User user,
    required String theFileSubjectName,
    required String theMessageFileName,
    required String theMessageDocId,
  }) async {
    final DocumentReference<Map<String, dynamic>> docMessage = firestoreInstance
        .collection("users2")
        .doc(user.uid)
        .collection("subjects")
        .doc(theFileSubjectName)
        .collection("files")
        .doc(theMessageFileName)
        .collection("messages")
        .doc(theMessageDocId);

    await docMessage.delete();
    return;
  }
}
