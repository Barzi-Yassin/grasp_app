// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspSubjectUpdateModel {
  String subjectItemsNumber;
  DateTime subjectUpdateAt;
  GraspSubjectUpdateModel({
    required this.subjectItemsNumber,
    required this.subjectUpdateAt,
  });

  GraspSubjectUpdateModel copyWith({
    String? subjectItemsNumber,
    DateTime? subjectUpdateAt,
  }) {
    return GraspSubjectUpdateModel(
      subjectItemsNumber: subjectItemsNumber ?? this.subjectItemsNumber,
      subjectUpdateAt: subjectUpdateAt ?? this.subjectUpdateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectItemsNumber': subjectItemsNumber,
      'subjectUpdateAt': subjectUpdateAt.millisecondsSinceEpoch,
    };
  }

  factory GraspSubjectUpdateModel.fromMap(Map<String, dynamic> map) {
    return GraspSubjectUpdateModel(
      subjectItemsNumber: map['subjectItemsNumber'] as String,
      subjectUpdateAt: DateTime.fromMillisecondsSinceEpoch(map['subjectUpdateAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspSubjectUpdateModel.fromJson(String source) => GraspSubjectUpdateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GraspSubjectUpdateModel(subjectItemsNumber: $subjectItemsNumber, subjectUpdateAt: $subjectUpdateAt)';

  @override
  bool operator ==(covariant GraspSubjectUpdateModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.subjectItemsNumber == subjectItemsNumber &&
      other.subjectUpdateAt == subjectUpdateAt;
  }

  @override
  int get hashCode => subjectItemsNumber.hashCode ^ subjectUpdateAt.hashCode;
}
