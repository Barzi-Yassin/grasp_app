// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspUserModel {
  int userInAppId;
  String uid;
  String email;
  String? name;
  String? imageUrl;
  DateTime createdAt;
  GraspUserModel({
    required this.userInAppId,
    required this.uid,
    required this.email,
    this.name,
    this.imageUrl,
    required this.createdAt,
  });

  GraspUserModel copyWith({
    int? userInAppId,
    String? uid,
    String? email,
    String? name,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return GraspUserModel(
      userInAppId: userInAppId ?? this.userInAppId,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userInAppId': userInAppId,
      'uid': uid,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory GraspUserModel.fromMap(Map<String, dynamic> map) {
    return GraspUserModel(
      userInAppId: map['userInAppId'] as int,
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspUserModel.fromJson(String source) => GraspUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspUserModel(userInAppId: $userInAppId, uid: $uid, email: $email, name: $name, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant GraspUserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userInAppId == userInAppId &&
      other.uid == uid &&
      other.email == email &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userInAppId.hashCode ^
      uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      createdAt.hashCode;
  }
}
