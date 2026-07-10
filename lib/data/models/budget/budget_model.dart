import 'dart:convert';

class BudgetModel {
  String? id;
  String userId;
  String category;
  int budgetAmount;
  bool? receiveAlert;
  int? alertPercentile;
  String? createdAt;
  String? updatedAt;

  DateTime? get createdAtDateTime =>
      createdAt != null ? DateTime.parse(createdAt!) : null;
  DateTime? get updatedAtDateTime =>
      updatedAt != null ? DateTime.parse(updatedAt!) : null;

  BudgetModel({
    this.id,
    required this.userId,
    required this.category,
    required this.budgetAmount,
    this.receiveAlert,
    this.alertPercentile,
    this.createdAt,
    this.updatedAt,
  });

  BudgetModel copyWith({
    String? id,
    String? userId,
    String? category,
    int? budgetAmount,
    bool? receiveAlert,
    int? alertPercentile,
    String? createdAt,
    String? updatedAt,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      receiveAlert: receiveAlert ?? this.receiveAlert,
      alertPercentile: alertPercentile ?? this.alertPercentile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'category': category,
      'budget_amount': budgetAmount,
      'receive_alert': receiveAlert != null ? (receiveAlert! ? 1 : 0) : null,
      'alert_percentile': alertPercentile,
      'created': createdAt,
      'updated': updatedAt,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['user_id'] as String,
      category: map['category'] as String,
      budgetAmount: (map['budget_amount'] as num).toInt(),
      receiveAlert: map['receive_alert'] != null
          ? (map['receive_alert'] as int) == 1
          : null,
      alertPercentile: map['alert_percentile'] != null
          ? map['alert_percentile'] as int
          : null,
      createdAt: map['created'] != null ? map['created'] as String : null,
      updatedAt: map['updated'] != null ? map['updated'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetModel.fromJson(String source) =>
      BudgetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BudgetModel(id: $id, userId: $userId, category: $category, budgetAmount: $budgetAmount, receiveAlert: $receiveAlert, alertPercentile: $alertPercentile, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant BudgetModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.category == category &&
        other.budgetAmount == budgetAmount &&
        other.receiveAlert == receiveAlert &&
        other.alertPercentile == alertPercentile &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        category.hashCode ^
        budgetAmount.hashCode ^
        receiveAlert.hashCode ^
        alertPercentile.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
