// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountsModel {
  String? id; // Changed to nullable
  String? created; // Changed to nullable
  String? updated; // Changed to nullable
  String userId;
  String name;
  String type;
  double balance;
  AccountsModel({
    this.id,
    this.created,
    this.updated,
    required this.userId,
    required this.name,
    required this.type,
    required this.balance,
  });

  AccountsModel copyWith({
    String? id,
    String? created,
    String? updated,
    String? userId,
    String? name,
    String? type,
    double? balance,
  }) {
    return AccountsModel(
      id: id ?? this.id,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created': created,
      'updated': updated,
      'user_id': userId,
      'name': name,
      'type': type,
      'balance': balance,
    };
  }

  factory AccountsModel.fromMap(Map<String, dynamic> map) {
    return AccountsModel(
      id: map['id'] != null ? map['id'] as String : null,
      created: map['created'] != null ? map['created'] as String : null,
      updated: map['updated'] != null ? map['updated'] as String : null,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      balance: (map['balance'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountsModel.fromJson(String source) =>
      AccountsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountsModel(id: $id, created: $created, updated: $updated, userId: $userId, name: $name, type: $type, balance: $balance)';
  }

  @override
  bool operator ==(covariant AccountsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created == created &&
        other.updated == updated &&
        other.userId == userId &&
        other.name == name &&
        other.type == type &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created.hashCode ^
        updated.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        type.hashCode ^
        balance.hashCode;
  }
}
