// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspSubjectModel {
  int subjectIdl;
  String subjectName;
  int subjectItemsNumber;
  DateTime subjectCreatedAt;
  GraspSubjectModel({
    required this.subjectIdl,
    required this.subjectName,
    required this.subjectItemsNumber,
    required this.subjectCreatedAt,
  });

  GraspSubjectModel copyWith({
    int? subjectIdl,
    String? subjectName,
    int? subjectItemsNumber,
    DateTime? subjectCreatedAt,
  }) {
    return GraspSubjectModel(
      subjectIdl: subjectIdl ?? this.subjectIdl,
      subjectName: subjectName ?? this.subjectName,
      subjectItemsNumber: subjectItemsNumber ?? this.subjectItemsNumber,
      subjectCreatedAt: subjectCreatedAt ?? this.subjectCreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectIdl': subjectIdl,
      'subjectName': subjectName,
      'subjectItemsNumber': subjectItemsNumber,
      'subjectCreatedAt': subjectCreatedAt.millisecondsSinceEpoch,
    };
  }

  factory GraspSubjectModel.fromMap(Map<String, dynamic> map) {
    return GraspSubjectModel(
      subjectIdl: map['subjectIdl'] as int,
      subjectName: map['subjectName'] as String,
      subjectItemsNumber: map['subjectItemsNumber'] as int,
      subjectCreatedAt:
          DateTime.fromMillisecondsSinceEpoch(map['subjectCreatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspSubjectModel.fromJson(String source) =>
      GraspSubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspSubjectModel(subjectIdl: $subjectIdl, subjectName: $subjectName, subjectItemsNumber: $subjectItemsNumber, subjectCreatedAt: $subjectCreatedAt)';
  }

  @override
  bool operator ==(covariant GraspSubjectModel other) {
    if (identical(this, other)) return true;

    return other.subjectIdl == subjectIdl &&
        other.subjectName == subjectName &&
        other.subjectItemsNumber == subjectItemsNumber &&
        other.subjectCreatedAt == subjectCreatedAt;
  }

  @override
  int get hashCode {
    return subjectIdl.hashCode ^
        subjectName.hashCode ^
        subjectItemsNumber.hashCode ^
        subjectCreatedAt.hashCode;
  }
}
