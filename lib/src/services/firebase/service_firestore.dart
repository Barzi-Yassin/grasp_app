
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grasp_app/src/models/grasp_file_model.dart';
import 'package:grasp_app/src/models/grasp_message_model.dart';
import 'package:grasp_app/src/models/secondary_models/grasp_fav_star_model.dart';
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
      imageUrl: "not inputed yet!",
      name: "Username",
    );

    await firestoreInstance
        .collection("users")
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
        .collection("users")
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
        .collection("users")
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
        .collection("users")
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
        .collection("users")
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
        .collection("users")
        .doc(user.uid)
        .collection("subjects")
        .doc(theFileSubjectName)
        .collection("files")
        .doc(theFileName)
        .set(graspFileModel.toMap());
    return graspFileModel;
  }

// add file to fav or star list
  Future<GraspFavStarModel> favStarFile({
    required User user,
    required String theFileSubjectName,
    required String theFileName,
    required String theFileCreatedAt,
    required bool isFileFaved,
    required bool isFileStared,
  }) async {
    GraspFavStarModel graspFavStarModel = GraspFavStarModel(
      uid: user.uid,
      fileSubjectName: theFileSubjectName,
      fileName: theFileName,
      isFileFaved: isFileFaved,
      isFileStared: isFileStared,
      fileCreatedAt: theFileCreatedAt,
      fileFavedOrStaredAt: DateTime.now(),
    );

    if (isFileFaved) {
      await firestoreInstance
          .collection("users")
          .doc(user.uid)
          .collection("favAndStars")
          .doc('favfiles')
          .collection("files")
          .doc(theFileName)
          .set(graspFavStarModel.toMap());
    }

    if (isFileStared) {
      await firestoreInstance
          .collection("users")
          .doc(user.uid)
          .collection("favAndStars")
          .doc('starfiles')
          .collection("files")
          .doc(theFileName)
          .set(graspFavStarModel.toMap());
    }

    return graspFavStarModel;
  }

// delete file from fav or star list
  Future unfavUnstarGraspFile({
    required User user,
    required String theFileName,
    required bool isFileUnfavedTrueUnstaredFalse,
  }) async {
    final String generateFavOrStar =
        isFileUnfavedTrueUnstaredFalse ? "favfiles" : "starfiles";

    await firestoreInstance
        .collection("users")
        .doc(user.uid)
        .collection("favAndStars")
        .doc(generateFavOrStar)
        .collection("files")
        .doc(theFileName)
        .delete();

    return;
  }

// delete file ::::::  // TODO: clean the message deletion process !!!
  Future deleteFile({
    required User user,
    required String theFileSubjectName,
    required String theFileName,
  }) async {
    final DocumentReference<Map<String, dynamic>> docFile = firestoreInstance
        .collection("users")
        .doc(user.uid)
        .collection("subjects")
        .doc(theFileSubjectName)
        .collection("files")
        .doc(theFileName);

    docMessageDeleteFunction({required String theDocMessageId}) async {
      final DocumentReference<Map<String, dynamic>> docMessage =
          firestoreInstance
              .collection("users")
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
            .collection("users")
            .doc(user.uid)
            .collection("subjects")
            .doc(theFileSubjectName)
            .collection("files")
            .doc(theFileName)
            .collection('messages')
            .snapshots();

    theStream.forEach((snapshotMessage) {
      // debugPrint('hellllllo :: ${snapshotMessage.docs.length}');
      // debugPrint('hellllllo :: $snapshotMessage');
      snapshotMessage.docs.forEach((snapshotMessage) async {
        final messageDocid = snapshotMessage.data()["messageDocId"];
        // debugPrint('hellllllo messageDocid ==== $messageDocid');
        docMessageDeleteFunction(theDocMessageId: messageDocid);
      });
    });

    await firestoreInstance
        .collection("users")
        .doc(user.uid)
        .collection("favAndStars")
        .doc('starfiles')
        .collection("files")
        .doc(theFileName)
        .delete();

    await firestoreInstance
        .collection("users")
        .doc(user.uid)
        .collection("favAndStars")
        .doc('favfiles')
        .collection("files")
        .doc(theFileName)
        .delete();

    await docFile.delete();
    return;
  }

  //  get subject items length
  // Future<String> getSubjectItemsLength(
  //     {required User user, required String theSubjectName}) async {
  //   final QuerySnapshot<Map<String, dynamic>> theSubjectFilesStream =
  //       await firestoreInstance
  //           .collection("users")
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
        .collection("users")
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
        .collection("users")
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
        .collection("users")
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

//  ------------------------------------------------------------------------------------------------------------------------------

  // Future<String> getUsernameOrProfileImageByFuture(
  //     {required User theUser, required bool isUsernameTrueOrImageFalse}) async {
  //   debugPrint('666 :: ${theUser.uid}');
  //   String result = 'skip hhha';
  //   String fieldNameGenerator =
  //       isUsernameTrueOrImageFalse ? "name" : "imageUrl";
  //   await firestoreInstance
  //       .collection('users')
  //       .doc(theUser.uid)
  //       .get()
  //       .then((value) {
  //     debugPrint(
  //         '666 :: kkk :: ${value.data()?[fieldNameGenerator] ?? 'null name'}');
  //     result = value.data()?[fieldNameGenerator] ?? "Username";
  //     debugPrint('666 :: kkk2 :: $result');
  //   });

  //   return result;
  // }
  /*
  // in destination.
  onTap: () async {
      String h = '///';
      await serviceFirestore
          .getUsernameOrProfileImageByFuture(
              theUser: widget.theUser!,
              isUsernameTrueOrImageFalse: false)
          .then((String value) => h = value);
      debugPrint('666 :::: $h ');
    },
*/
}
