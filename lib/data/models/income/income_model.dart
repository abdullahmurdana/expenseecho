// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IncomeModel {
  String id;
  String createdAt;
  String updatedAt;
  String userId;
  String accountId;
  String category;
  String description;
  double incomeAmount;
  String? attachmentLink;
  bool repeated;
  String frequency;
  String endAfterDate;
  IncomeModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.accountId,
    required this.category,
    required this.description,
    required this.incomeAmount,
    this.attachmentLink,
    required this.repeated,
    required this.frequency,
    required this.endAfterDate,
  });

  IncomeModel copyWith({
    String? id,
    String? created,
    String? updated,
    String? userId,
    String? accountId,
    String? category,
    String? description,
    double? incomeAmount,
    String? attachmentLink,
    bool? repeated,
    String? frequency,
    String? endAfterDate,
  }) {
    return IncomeModel(
      id: id ?? this.id,
      createdAt: created ?? createdAt,
      updatedAt: updated ?? updatedAt,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      description: description ?? this.description,
      incomeAmount: incomeAmount ?? this.incomeAmount,
      attachmentLink: attachmentLink ?? this.attachmentLink,
      repeated: repeated ?? this.repeated,
      frequency: frequency ?? this.frequency,
      endAfterDate: endAfterDate ?? this.endAfterDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created': createdAt,
      'updated': updatedAt,
      'user_id': userId,
      'account_id': accountId,
      'category': category,
      'description': description,
      'income_amount': incomeAmount,
      'attachment_link': attachmentLink,
      'repeated': repeated,
      'frequency': frequency,
      'end_after_date': endAfterDate,
    };
  }

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'] as String,
      createdAt: map['created'] as String,
      updatedAt: map['updated'] as String,
      userId: map['user_id'] as String,
      accountId: map['account_id'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      incomeAmount: map['income_amount'] as double,
      attachmentLink: map['attachment_link'] != null
          ? map['attachmentLink'] as String
          : null,
      repeated: map['repeated'] as bool,
      frequency: map['frequency'] as String,
      endAfterDate: map['end_after_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomeModel.fromJson(String source) =>
      IncomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IncomeModel(id: $id, created: $createdAt, updated: $updatedAt, userId: $userId, accountId: $accountId, category: $category, description: $description, incomeAmount: $incomeAmount, attachmentLink: $attachmentLink, repeated: $repeated, frequency: $frequency, endAfterDate: $endAfterDate)';
  }

  @override
  bool operator ==(covariant IncomeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.userId == userId &&
        other.accountId == accountId &&
        other.category == category &&
        other.description == description &&
        other.incomeAmount == incomeAmount &&
        other.attachmentLink == attachmentLink &&
        other.repeated == repeated &&
        other.frequency == frequency &&
        other.endAfterDate == endAfterDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        userId.hashCode ^
        accountId.hashCode ^
        category.hashCode ^
        description.hashCode ^
        incomeAmount.hashCode ^
        attachmentLink.hashCode ^
        repeated.hashCode ^
        frequency.hashCode ^
        endAfterDate.hashCode;
  }
}
