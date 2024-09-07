// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExpenseModel {
  String id;
  String userId;
  String accountId;
  String category;
  String description;
  double expenseAmount;
  String? attachmentLink;
  bool repeated;
  String endAfterDate;
  String frequency;
  String createdAt;
  String updatedAt;
  ExpenseModel({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.category,
    required this.description,
    required this.expenseAmount,
    this.attachmentLink,
    required this.repeated,
    required this.endAfterDate,
    required this.frequency,
    required this.createdAt,
    required this.updatedAt,
  });

  ExpenseModel copyWith({
    String? id,
    String? userId,
    String? accountId,
    String? category,
    String? description,
    double? expenseAmount,
    String? attachmentLink,
    bool? repeated,
    String? endAfterDate,
    String? frequency,
    String? createdAt,
    String? updatedAt,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      description: description ?? this.description,
      expenseAmount: expenseAmount ?? this.expenseAmount,
      attachmentLink: attachmentLink ?? this.attachmentLink,
      repeated: repeated ?? this.repeated,
      endAfterDate: endAfterDate ?? this.endAfterDate,
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'account_id': accountId,
      'category': category,
      'description': description,
      'expense_amount': expenseAmount,
      'attachment_link': attachmentLink,
      'repeated': repeated,
      'end_after_date': endAfterDate,
      'frequency': frequency,
      'created': createdAt,
      'updated': updatedAt,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      accountId: map['account_id'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      expenseAmount: map['expense_amount'] as double,
      attachmentLink: map['attachment_link'] != null
          ? map['attachmentLink'] as String
          : null,
      repeated: map['repeated'] as bool,
      endAfterDate: map['end_after_date'] as String,
      frequency: map['frequency'] as String,
      createdAt: map['created'] as String,
      updatedAt: map['updated'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExpenseModel(id: $id, userId: $userId, accountId: $accountId, category: $category, description: $description, expenseAmount: $expenseAmount, attachmentLink: $attachmentLink, repeated: $repeated, endAfterDate: $endAfterDate, frequency: $frequency, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ExpenseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.accountId == accountId &&
        other.category == category &&
        other.description == description &&
        other.expenseAmount == expenseAmount &&
        other.attachmentLink == attachmentLink &&
        other.repeated == repeated &&
        other.endAfterDate == endAfterDate &&
        other.frequency == frequency &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        accountId.hashCode ^
        category.hashCode ^
        description.hashCode ^
        expenseAmount.hashCode ^
        attachmentLink.hashCode ^
        repeated.hashCode ^
        endAfterDate.hashCode ^
        frequency.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
