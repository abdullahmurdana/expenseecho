// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String username;
  final String avatarLink;
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.username,
    required this.avatarLink,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? username,
    String? avatarLink,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      avatarLink: avatarLink ?? this.avatarLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': userId,
      'name': name,
      'email': email,
      'username': username,
      'avatar_link': avatarLink,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      avatarLink: map['avatar_link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, email: $email, username: $username, avatarLink: $avatarLink)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.username == username &&
        other.avatarLink == avatarLink;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        username.hashCode ^
        avatarLink.hashCode;
  }
}
