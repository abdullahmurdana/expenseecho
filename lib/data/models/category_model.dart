import 'dart:ui';

import 'package:expenseecho/core/utils/theme_colors.dart';

class CategoryModel {
  final String name;
  final String imagePath;
  final Color backgroundColor;
  final Color foregroundColor; // New attribute

  CategoryModel({
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
    required this.foregroundColor, // New attribute
  });

  // Convert a Category object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePath': imagePath,
      'backgroundColor': backgroundColor.value, // Convert Color to int
      'foregroundColor': foregroundColor.value, // Convert Color to int
    };
  }

  // Extract a Category object from a Map object
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'],
      imagePath: map['imagePath'],
      backgroundColor: Color(map['backgroundColor']), // Convert int to Color
      foregroundColor: Color(map['foregroundColor']), // Convert int to Color
    );
  }
}

List<CategoryModel> majorExpenseCategories = [
  CategoryModel(
    name: 'Transportation',
    imagePath: 'assets/icons/transportation_icon.png',
    backgroundColor: iconToBackgroundColor['Transportation']!,
    foregroundColor: iconForegroundColor['Transportation']!, // New attribute
  ),
  CategoryModel(
    name: 'Shopping',
    imagePath: 'assets/icons/shopping_bag_icon.png',
    backgroundColor: iconToBackgroundColor['Shopping']!,
    foregroundColor: iconForegroundColor['Shopping']!, // New attribute
  ),
  CategoryModel(
    name: 'Utility Bills',
    imagePath: 'assets/icons/utility_bill_icon.png',
    backgroundColor: iconToBackgroundColor['Utility Bills']!,
    foregroundColor: iconForegroundColor['Utility Bills']!, // New attribute
  ),
  CategoryModel(
    name: 'Subscriptions',
    imagePath: 'assets/icons/subscription_icon.png',
    backgroundColor: iconToBackgroundColor['Subscriptions']!,
    foregroundColor: iconForegroundColor['Subscriptions']!, // New attribute
  ),
  CategoryModel(
    name: 'Food',
    imagePath: 'assets/icons/food_icon.png',
    backgroundColor: iconToBackgroundColor['Food']!,
    foregroundColor: iconForegroundColor['Food']!, // New attribute
  ),
];

List<CategoryModel> majorIncomeCategories = [
  CategoryModel(
    name: 'Salary',
    imagePath: 'assets/icons/salary_icon.png',
    backgroundColor: iconToBackgroundColor['Salary']!,
    foregroundColor: iconForegroundColor['Salary']!, // New attribute
  ),
  CategoryModel(
    name: 'Passive Income',
    imagePath: 'assets/icons/salary_icon_dark.png',
    backgroundColor: iconToBackgroundColor['Passive Income']!,
    foregroundColor: iconForegroundColor['Passive Income']!, // New attribute
  ),
];
