// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GraspUser {
  int userInAppId;
  String uid;
  String email;
  String? name;
  String? imgUrl;
  DateTime createdAt;
  GraspUser({
    required this.userInAppId,
    required this.uid,
    required this.email,
    this.name,
    this.imgUrl,
    required this.createdAt,
  });

  GraspUser copyWith({
    int? userInAppId,
    String? uid,
    String? email,
    String? name,
    String? imgUrl,
    DateTime? createdAt,
  }) {
    return GraspUser(
      userInAppId: userInAppId ?? this.userInAppId,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userInAppId': userInAppId,
      'uid': uid,
      'email': email,
      'name': name,
      'imgUrl': imgUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory GraspUser.fromMap(Map<String, dynamic> map) {
    return GraspUser(
      userInAppId: map['userInAppId'] as int,
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GraspUser.fromJson(String source) => GraspUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GraspUser(userInAppId: $userInAppId, uid: $uid, email: $email, name: $name, imgUrl: $imgUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant GraspUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.userInAppId == userInAppId &&
      other.uid == uid &&
      other.email == email &&
      other.name == name &&
      other.imgUrl == imgUrl &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userInAppId.hashCode ^
      uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      imgUrl.hashCode ^
      createdAt.hashCode;
  }
}
