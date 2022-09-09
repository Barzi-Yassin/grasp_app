// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspFileModel {
  String uid;
  String fileSubjectIdName;
  String fileName;
  String fileId;
  bool? isFileStared;
  bool? isFileFaved;
  DateTime fileCreatedAt;
  DateTime fileUpdatedAt;
  GraspFileModel({
    required this.uid,
    required this.fileSubjectIdName,
    required this.fileName,
    required this.fileId,
    this.isFileStared,
    this.isFileFaved,
    required this.fileCreatedAt,
    required this.fileUpdatedAt,
  });
  

  GraspFileModel copyWith({
    String? uid,
    String? fileSubjectIdName,
    String? fileName,
    String? fileId,
    bool? isFileStared,
    bool? isFileFaved,
    DateTime? fileCreatedAt,
    DateTime? fileUpdatedAt,
  }) {
    return GraspFileModel(
      uid: uid ?? this.uid,
      fileSubjectIdName: fileSubjectIdName ?? this.fileSubjectIdName,
      fileName: fileName ?? this.fileName,
      fileId: fileId ?? this.fileId,
      isFileStared: isFileStared ?? this.isFileStared,
      isFileFaved: isFileFaved ?? this.isFileFaved,
      fileCreatedAt: fileCreatedAt ?? this.fileCreatedAt,
      fileUpdatedAt: fileUpdatedAt ?? this.fileUpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fileSubjectIdName': fileSubjectIdName,
      'fileName': fileName,
      'fileId': fileId,
      'isFileStared': isFileStared,
      'isFileFaved': isFileFaved,
      'fileCreatedAt': fileCreatedAt.millisecondsSinceEpoch,
      'fileUpdatedAt': fileUpdatedAt.millisecondsSinceEpoch,
    };
  }

  factory GraspFileModel.fromMap(Map<String, dynamic> map) {
    return GraspFileModel(
      uid: map['uid'] as String,
      fileSubjectIdName: map['fileSubjectIdName'] as String,
      fileName: map['fileName'] as String,
      fileId: map['fileId'] as String,
      isFileStared: map['isFileStared'] != null ? map['isFileStared'] as bool : null,
      isFileFaved: map['isFileFaved'] != null ? map['isFileFaved'] as bool : null,
      fileCreatedAt: DateTime.fromMillisecondsSinceEpoch(map['fileCreatedAt'] as int),
      fileUpdatedAt: DateTime.fromMillisecondsSinceEpoch(map['fileUpdatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspFileModel.fromJson(String source) => GraspFileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspFileModel(uid: $uid, fileSubjectIdName: $fileSubjectIdName, fileName: $fileName, fileId: $fileId, isFileStared: $isFileStared, isFileFaved: $isFileFaved, fileCreatedAt: $fileCreatedAt, fileUpdatedAt: $fileUpdatedAt)';
  }

  @override
  bool operator ==(covariant GraspFileModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.fileSubjectIdName == fileSubjectIdName &&
      other.fileName == fileName &&
      other.fileId == fileId &&
      other.isFileStared == isFileStared &&
      other.isFileFaved == isFileFaved &&
      other.fileCreatedAt == fileCreatedAt &&
      other.fileUpdatedAt == fileUpdatedAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      fileSubjectIdName.hashCode ^
      fileName.hashCode ^
      fileId.hashCode ^
      isFileStared.hashCode ^
      isFileFaved.hashCode ^
      fileCreatedAt.hashCode ^
      fileUpdatedAt.hashCode;
  }
}
