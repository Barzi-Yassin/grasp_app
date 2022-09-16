// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspMessageReactionModel {
  bool isReacted;
  GraspMessageReactionModel({
    required this.isReacted,
  });

  GraspMessageReactionModel copyWith({
    bool? isReacted,
  }) {
    return GraspMessageReactionModel(
      isReacted: isReacted ?? this.isReacted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isReacted': isReacted,
    };
  }

  factory GraspMessageReactionModel.fromMap(Map<String, dynamic> map) {
    return GraspMessageReactionModel(
      isReacted: map['isReacted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspMessageReactionModel.fromJson(String source) => GraspMessageReactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GraspMessageReactionModel(isReacted: $isReacted)';

  @override
  bool operator ==(covariant GraspMessageReactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.isReacted == isReacted;
  }

  @override
  int get hashCode => isReacted.hashCode;
}
