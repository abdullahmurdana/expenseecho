import 'dart:convert';

class ExpenseModel {
  String? id;
  String userId;
  String accountId;
  String category;
  String title;
  String description;
  double expenseAmount;
  String? attachmentLink;
  bool repeated;
  String? frequency;
  String? endAfterDate;
  String? startDate;
  String? createdAt;
  String? updatedAt;

  DateTime? get createdAtDateTime =>
      createdAt != null ? DateTime.parse(createdAt!) : null;
  DateTime? get updatedAtDateTime =>
      updatedAt != null ? DateTime.parse(updatedAt!) : null;
  DateTime? get startDateTime =>
      startDate != null ? DateTime.parse(startDate!) : null;
  DateTime? get endAfterDateTime =>
      endAfterDate != null ? DateTime.parse(endAfterDate!) : null;

  ExpenseModel({
    this.id,
    required this.userId,
    required this.accountId,
    required this.category,
    required this.title,
    required this.description,
    required this.expenseAmount,
    this.attachmentLink,
    required this.repeated,
    this.frequency,
    this.endAfterDate,
    this.startDate,
    this.createdAt,
    this.updatedAt,
  });

  ExpenseModel copyWith({
    String? id,
    String? userId,
    String? accountId,
    String? category,
    String? title,
    String? description,
    double? expenseAmount,
    String? attachmentLink,
    bool? repeated,
    String? frequency,
    String? endAfterDate,
    String? startDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      expenseAmount: expenseAmount ?? this.expenseAmount,
      attachmentLink: attachmentLink ?? this.attachmentLink,
      repeated: repeated ?? this.repeated,
      frequency: frequency ?? this.frequency,
      endAfterDate: endAfterDate ?? this.endAfterDate,
      startDate: startDate ?? this.startDate,
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
      'title': title,
      'description': description,
      'expense_amount': expenseAmount,
      'attachment_link': attachmentLink,
      'repeated': repeated ? 1 : 0,
      'frequency': frequency,
      'end_after_date': endAfterDate,
      'start_date': startDate,
      'created': createdAt,
      'updated': updatedAt,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['user_id'] as String,
      accountId: map['account_id'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      expenseAmount: (map['expense_amount'] as num).toDouble(),
      attachmentLink: map['attachment_link'] != null
          ? map['attachment_link'] as String
          : null,
      repeated: map['repeated'] == 1,
      frequency: map['frequency'] != null ? map['frequency'] as String : null,
      endAfterDate: map['end_after_date'] != null
          ? map['end_after_date'] as String
          : null,
      startDate: map['start_date'] != null ? map['start_date'] as String : null,
      createdAt: map['created'] != null ? map['created'] as String : null,
      updatedAt: map['updated'] != null ? map['updated'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExpenseModel(id: $id, userId: $userId, accountId: $accountId, category: $category, title: $title, description: $description, expenseAmount: $expenseAmount, attachmentLink: $attachmentLink, repeated: $repeated, frequency: $frequency, endAfterDate: $endAfterDate, startDate: $startDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ExpenseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.accountId == accountId &&
        other.category == category &&
        other.title == title &&
        other.description == description &&
        other.expenseAmount == expenseAmount &&
        other.attachmentLink == attachmentLink &&
        other.repeated == repeated &&
        other.frequency == frequency &&
        other.endAfterDate == endAfterDate &&
        other.startDate == startDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        accountId.hashCode ^
        category.hashCode ^
        title.hashCode ^
        description.hashCode ^
        expenseAmount.hashCode ^
        attachmentLink.hashCode ^
        repeated.hashCode ^
        frequency.hashCode ^
        endAfterDate.hashCode ^
        startDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
