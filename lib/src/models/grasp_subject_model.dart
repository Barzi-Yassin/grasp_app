// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspSubjectModel {
  String uid;
  String subjectName;
  String subjectItemsNumber;
  DateTime subjectUpdateAt;
  DateTime subjectCreatedAt;
  GraspSubjectModel({
    required this.uid,
    required this.subjectName,
    required this.subjectItemsNumber,
    required this.subjectUpdateAt,
    required this.subjectCreatedAt,
  });

  GraspSubjectModel copyWith({
    String? uid,
    String? subjectName,
    String? subjectItemsNumber,
    DateTime? subjectUpdateAt,
    DateTime? subjectCreatedAt,
  }) {
    return GraspSubjectModel(
      uid: uid ?? this.uid,
      subjectName: subjectName ?? this.subjectName,
      subjectItemsNumber: subjectItemsNumber ?? this.subjectItemsNumber,
      subjectUpdateAt: subjectUpdateAt ?? this.subjectUpdateAt,
      subjectCreatedAt: subjectCreatedAt ?? this.subjectCreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'subjectName': subjectName,
      'subjectItemsNumber': subjectItemsNumber,
      'subjectUpdateAt': subjectUpdateAt.millisecondsSinceEpoch,
      'subjectCreatedAt': subjectCreatedAt.millisecondsSinceEpoch,
    };
  }

  factory GraspSubjectModel.fromMap(Map<String, dynamic> map) {
    return GraspSubjectModel(
      uid: map['uid'] as String,
      subjectName: map['subjectName'] as String,
      subjectItemsNumber: map['subjectItemsNumber'] as String,
      subjectUpdateAt: DateTime.fromMillisecondsSinceEpoch(map['subjectUpdateAt'] as int),
      subjectCreatedAt: DateTime.fromMillisecondsSinceEpoch(map['subjectCreatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspSubjectModel.fromJson(String source) => GraspSubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspSubjectModel(uid: $uid, subjectName: $subjectName, subjectItemsNumber: $subjectItemsNumber, subjectUpdateAt: $subjectUpdateAt, subjectCreatedAt: $subjectCreatedAt)';
  }

  @override
  bool operator ==(covariant GraspSubjectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.subjectName == subjectName &&
      other.subjectItemsNumber == subjectItemsNumber &&
      other.subjectUpdateAt == subjectUpdateAt &&
      other.subjectCreatedAt == subjectCreatedAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      subjectName.hashCode ^
      subjectItemsNumber.hashCode ^
      subjectUpdateAt.hashCode ^
      subjectCreatedAt.hashCode;
  }
}
