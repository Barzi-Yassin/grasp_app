// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspSubjectModel {
  String uid;
  String subjectName;
  int subjectIdl;
  int subjectItemsNumber;
  DateTime subjectCreatedAt;
  GraspSubjectModel({
    required this.uid,
    required this.subjectName,
    required this.subjectIdl,
    required this.subjectItemsNumber,
    required this.subjectCreatedAt,
  });

  GraspSubjectModel copyWith({
    String? uid,
    String? subjectName,
    int? subjectIdl,
    int? subjectItemsNumber,
    DateTime? subjectCreatedAt,
  }) {
    return GraspSubjectModel(
      uid: uid ?? this.uid,
      subjectName: subjectName ?? this.subjectName,
      subjectIdl: subjectIdl ?? this.subjectIdl,
      subjectItemsNumber: subjectItemsNumber ?? this.subjectItemsNumber,
      subjectCreatedAt: subjectCreatedAt ?? this.subjectCreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'subjectName': subjectName,
      'subjectIdl': subjectIdl,
      'subjectItemsNumber': subjectItemsNumber,
      'subjectCreatedAt': subjectCreatedAt.millisecondsSinceEpoch,
    };
  }

  factory GraspSubjectModel.fromMap(Map<String, dynamic> map) {
    return GraspSubjectModel(
      uid: map['uid'] as String,
      subjectName: map['subjectName'] as String,
      subjectIdl: map['subjectIdl'] as int,
      subjectItemsNumber: map['subjectItemsNumber'] as int,
      subjectCreatedAt: DateTime.fromMillisecondsSinceEpoch(map['subjectCreatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspSubjectModel.fromJson(String source) => GraspSubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspSubjectModel(uid: $uid, subjectName: $subjectName, subjectIdl: $subjectIdl, subjectItemsNumber: $subjectItemsNumber, subjectCreatedAt: $subjectCreatedAt)';
  }

  @override
  bool operator ==(covariant GraspSubjectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.subjectName == subjectName &&
      other.subjectIdl == subjectIdl &&
      other.subjectItemsNumber == subjectItemsNumber &&
      other.subjectCreatedAt == subjectCreatedAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      subjectName.hashCode ^
      subjectIdl.hashCode ^
      subjectItemsNumber.hashCode ^
      subjectCreatedAt.hashCode;
  }
}
