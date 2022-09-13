// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspMessageModel {
  String messageDocId;
  String message;
  String messageFileName;
  bool? isReacted;
  DateTime createdAt;
  GraspMessageModel({
    this.messageDocId = '',
    required this.message,
    required this.messageFileName,
    this.isReacted,
    required this.createdAt,
  });

  GraspMessageModel copyWith({
    String? messageDocId,
    String? message,
    String? messageFileName,
    bool? isReacted,
    DateTime? createdAt,
  }) {
    return GraspMessageModel(
      messageDocId: messageDocId ?? this.messageDocId,
      message: message ?? this.message,
      messageFileName: messageFileName ?? this.messageFileName,
      isReacted: isReacted ?? this.isReacted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageDocId': messageDocId,
      'message': message,
      'messageFileName': messageFileName,
      'isReacted': isReacted,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory GraspMessageModel.fromMap(Map<String, dynamic> map) {
    return GraspMessageModel(
      messageDocId: map['messageDocId'] as String,
      message: map['message'] as String,
      messageFileName: map['messageFileName'] as String,
      isReacted: map['isReacted'] != null ? map['isReacted'] as bool : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspMessageModel.fromJson(String source) =>
      GraspMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspMessageModel(messageDocId: $messageDocId, message: $message, messageFileName: $messageFileName, isReacted: $isReacted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant GraspMessageModel other) {
    if (identical(this, other)) return true;

    return other.messageDocId == messageDocId &&
        other.message == message &&
        other.messageFileName == messageFileName &&
        other.isReacted == isReacted &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return messageDocId.hashCode ^
        message.hashCode ^
        messageFileName.hashCode ^
        isReacted.hashCode ^
        createdAt.hashCode;
  }
}
