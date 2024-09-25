import 'dart:convert';

class IncomeModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  String userId;
  String accountId;
  String category;
  String title;
  String description;
  double incomeAmount;
  String? attachmentLink;
  bool repeated;
  String? frequency;
  String? startDate;
  String? endAfterDate;

  DateTime? get createdAtDateTime =>
      createdAt != null ? DateTime.parse(createdAt!) : null;
  DateTime? get updatedAtDateTime =>
      updatedAt != null ? DateTime.parse(updatedAt!) : null;
  DateTime? get startDateTime =>
      startDate != null ? DateTime.parse(startDate!) : null;
  DateTime? get endAfterDateTime =>
      endAfterDate != null ? DateTime.parse(endAfterDate!) : null;

  IncomeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.userId,
    required this.accountId,
    required this.category,
    required this.title,
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
    String? title,
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
      createdAt: created ?? createdAt,
      updatedAt: updated ?? updatedAt,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      title: title ?? this.title,
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
      'created': createdAt,
      'updated': updatedAt,
      'user_id': userId,
      'account_id': accountId,
      'category': category,
      'title': title,
      'description': description,
      'income_amount': incomeAmount,
      'attachment_link': attachmentLink,
      'repeated': repeated ? 1 : 0, // Changed to store as integer
      'frequency': frequency,
      'start_date': startDate,
      'end_after_date': endAfterDate,
    };
  }

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'] != null ? map['id'] as String : null,
      createdAt: map['created'] != null ? map['created'] as String : null,
      updatedAt: map['updated'] != null ? map['updated'] as String : null,
      userId: map['user_id'] as String,
      accountId: map['account_id'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      incomeAmount: (map['income_amount'] as num).toDouble(),
      attachmentLink: map['attachment_link'] != null
          ? map['attachment_link'] as String
          : null,
      repeated: map['repeated'] == 1, // Changed to read as boolean
      frequency: map['frequency'] != null ? map['frequency'] as String : null,
      startDate: map['start_date'] != null ? map['start_date'] as String : null,
      endAfterDate: map['end_after_date'] != null
          ? map['end_after_date'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomeModel.fromJson(String source) =>
      IncomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IncomeModel(id: $id, created: $createdAt, updated: $updatedAt, userId: $userId, accountId: $accountId, category: $category, title: $title, description: $description, incomeAmount: $incomeAmount, attachmentLink: $attachmentLink, repeated: $repeated, frequency: $frequency, startDate: $startDate, endAfterDate: $endAfterDate)';
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
        other.title == title &&
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
        createdAt.hashCode ^
        updatedAt.hashCode ^
        userId.hashCode ^
        accountId.hashCode ^
        category.hashCode ^
        title.hashCode ^
        description.hashCode ^
        incomeAmount.hashCode ^
        attachmentLink.hashCode ^
        repeated.hashCode ^
        frequency.hashCode ^
        startDate.hashCode ^
        endAfterDate.hashCode;
  }
}
