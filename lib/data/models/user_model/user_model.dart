// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? id;
  final String name;
  final String email;
  String? username;
  final String password;
  String? avatarLink;
  String? createdAt;
  String? updatedAt;
  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.username,
    required this.password,
    this.avatarLink,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? username,
    String? password,
    String? avatarLink,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      avatarLink: avatarLink ?? this.avatarLink,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'avatar_link': avatarLink,
      'created': createdAt,
      'updated': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] as String,
      avatarLink:
          map['avatar_link'] != null ? map['avatar_link'] as String : null,
      createdAt: map['created'] != null ? map['created'] as String : null,
      updatedAt: map['updated'] != null ? map['updated'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, username: $username, password: $password, avatarLink: $avatarLink, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.username == username &&
        other.password == password &&
        other.avatarLink == avatarLink &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        username.hashCode ^
        password.hashCode ^
        avatarLink.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
