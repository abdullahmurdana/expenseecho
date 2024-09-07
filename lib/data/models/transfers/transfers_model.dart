// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransfersModel {
  String id;
  String userId;
  String fromAccountId;
  String toAccountId;
  double amount;
  String description;
  String createdAt;
  String updatedAt;
  TransfersModel({
    required this.id,
    required this.userId,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'description': description,
      'amount': amount,
      'created': createdAt,
      'updated': updatedAt,
    };
  }

  factory TransfersModel.fromMap(Map<String, dynamic> map) {
    return TransfersModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      fromAccountId: map['from_account_id'] as String,
      toAccountId: map['to_account_id'] as String,
      description: map['description'] as String,
      amount: map['amount'] as double,
      createdAt: map['created'] as String,
      updatedAt: map['updated'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransfersModel.fromJson(String source) =>
      TransfersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransfersModel(id: $id, userId: $userId, fromAccountId: $fromAccountId, toAccountId: $toAccountId, Description: $description, amount: $amount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant TransfersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.fromAccountId == fromAccountId &&
        other.toAccountId == toAccountId &&
        other.description == description &&
        other.amount == amount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        fromAccountId.hashCode ^
        toAccountId.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  TransfersModel copyWith({
    String? id,
    String? userId,
    String? fromAccountId,
    String? toAccountId,
    double? amount,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return TransfersModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
