import 'dart:convert';

class AccountsModel {
  String id;
  String createdAt;
  String updatedAt;
  String userId;
  String name;
  String type;
  double balance;

  AccountsModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.name,
    required this.type,
    required this.balance,
  });

  AccountsModel copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? userId,
    String? name,
    String? type,
    double? balance,
  }) {
    return AccountsModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created': createdAt,
      'updated': updatedAt,
      'user_id': userId,
      'name': name,
      'type': type,
      'balance': balance,
    };
  }

  factory AccountsModel.fromMap(Map<String, dynamic> map) {
    return AccountsModel(
      id: map['id'] as String,
      createdAt: map['created'] as String,
      updatedAt: map['updated'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      balance:
          (map['balance'] as num).toDouble(), // Handle int to double conversion
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountsModel.fromJson(String source) =>
      AccountsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountsModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, name: $name, type: $type, balance: $balance)';
  }

  @override
  bool operator ==(covariant AccountsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.userId == userId &&
        other.name == name &&
        other.type == type &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        type.hashCode ^
        balance.hashCode;
  }
}
