// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspFavStarModel {
  String uid;
  String fileSubjectName;
  String fileName;
  bool isFileFaved;
  bool isFileStared;
  GraspFavStarModel({
    required this.uid,
    required this.fileSubjectName,
    required this.fileName,
    required this.isFileFaved,
    required this.isFileStared,
  });

  GraspFavStarModel copyWith({
    String? uid,
    String? fileSubjectName,
    String? fileName,
    bool? isFileFaved,
    bool? isFileStared,
  }) {
    return GraspFavStarModel(
      uid: uid ?? this.uid,
      fileSubjectName: fileSubjectName ?? this.fileSubjectName,
      fileName: fileName ?? this.fileName,
      isFileFaved: isFileFaved ?? this.isFileFaved,
      isFileStared: isFileStared ?? this.isFileStared,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fileSubjectName': fileSubjectName,
      'fileName': fileName,
      'isFileFaved': isFileFaved,
      'isFileStared': isFileStared,
    };
  }

  factory GraspFavStarModel.fromMap(Map<String, dynamic> map) {
    return GraspFavStarModel(
      uid: map['uid'] as String,
      fileSubjectName: map['fileSubjectName'] as String,
      fileName: map['fileName'] as String,
      isFileFaved: map['isFileFaved'] as bool,
      isFileStared: map['isFileStared'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspFavStarModel.fromJson(String source) => GraspFavStarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspFavStarModel(uid: $uid, fileSubjectName: $fileSubjectName, fileName: $fileName, isFileFaved: $isFileFaved, isFileStared: $isFileStared)';
  }

  @override
  bool operator ==(covariant GraspFavStarModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.fileSubjectName == fileSubjectName &&
      other.fileName == fileName &&
      other.isFileFaved == isFileFaved &&
      other.isFileStared == isFileStared;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      fileSubjectName.hashCode ^
      fileName.hashCode ^
      isFileFaved.hashCode ^
      isFileStared.hashCode;
  }
}
