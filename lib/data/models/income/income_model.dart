// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IncomeModel {
  String? id;
  String? created;
  String? updated;
  String userId;
  String accountId;
  String category;
  String description;
  double incomeAmount;
  String? attachmentLink;
  bool repeated;
  String? frequency;
  String? startDate;
  String? endAfterDate;
  IncomeModel({
    this.id,
    this.created,
    this.updated,
    required this.userId,
    required this.accountId,
    required this.category,
    required this.description,
    required this.incomeAmount,
    this.attachmentLink,
    required this.repeated,
    this.frequency,
    this.startDate,
    this.endAfterDate,
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
    String? startDate,
    String? endAfterDate,
  }) {
    return IncomeModel(
      id: id ?? this.id,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      description: description ?? this.description,
      incomeAmount: incomeAmount ?? this.incomeAmount,
      attachmentLink: attachmentLink ?? this.attachmentLink,
      repeated: repeated ?? this.repeated,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endAfterDate: endAfterDate ?? this.endAfterDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created': created,
      'updated': updated,
      'userId': userId,
      'accountId': accountId,
      'category': category,
      'description': description,
      'incomeAmount': incomeAmount,
      'attachmentLink': attachmentLink,
      'repeated': repeated,
      'frequency': frequency,
      'startDate': startDate,
      'endAfterDate': endAfterDate,
    };
  }

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'] != null ? map['id'] as String : null,
      created: map['created'] != null ? map['created'] as String : null,
      updated: map['updated'] != null ? map['updated'] as String : null,
      userId: map['userId'] as String,
      accountId: map['accountId'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      incomeAmount: map['incomeAmount'] as double,
      attachmentLink: map['attachmentLink'] != null
          ? map['attachmentLink'] as String
          : null,
      repeated: map['repeated'] as bool,
      frequency: map['frequency'] != null ? map['frequency'] as String : null,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
      endAfterDate:
          map['endAfterDate'] != null ? map['endAfterDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomeModel.fromJson(String source) =>
      IncomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IncomeModel(id: $id, created: $created, updated: $updated, userId: $userId, accountId: $accountId, category: $category, description: $description, incomeAmount: $incomeAmount, attachmentLink: $attachmentLink, repeated: $repeated, frequency: $frequency, startDate: $startDate, endAfterDate: $endAfterDate)';
  }

  @override
  bool operator ==(covariant IncomeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created == created &&
        other.updated == updated &&
        other.userId == userId &&
        other.accountId == accountId &&
        other.category == category &&
        other.description == description &&
        other.incomeAmount == incomeAmount &&
        other.attachmentLink == attachmentLink &&
        other.repeated == repeated &&
        other.frequency == frequency &&
        other.startDate == startDate &&
        other.endAfterDate == endAfterDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created.hashCode ^
        updated.hashCode ^
        userId.hashCode ^
        accountId.hashCode ^
        category.hashCode ^
        description.hashCode ^
        incomeAmount.hashCode ^
        attachmentLink.hashCode ^
        repeated.hashCode ^
        frequency.hashCode ^
        startDate.hashCode ^
        endAfterDate.hashCode;
  }
}
