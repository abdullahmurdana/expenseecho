import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:expenseecho/data/models/category_model.dart';

class CategoryPreferences {
  static const String _expenseCategoriesKey = 'expense_categories';
  static const String _incomeCategoriesKey = 'income_categories';

  static Future<void> saveIncomeCategories(
      List<CategoryModel> categories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categoriesJson =
        categories.map((category) => json.encode(category.toMap())).toList();
    await prefs.setStringList(_incomeCategoriesKey, categoriesJson);
    print("---> Saved income categories...");
  }

  static Future<List<CategoryModel>> loadIncomeCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJson = prefs.getStringList(_incomeCategoriesKey);
    if (categoriesJson == null) {
      return [];
    }
    return categoriesJson
        .map((categoryJson) => CategoryModel.fromMap(json.decode(categoryJson)))
        .toList();
  }

  static Future<void> saveIncomeCategory(CategoryModel category) async {
    List<CategoryModel> categories = await loadIncomeCategories();
    categories.add(category);
    await saveIncomeCategories(categories);
  }

  static Future<void> saveExpenseCategories(
      List<CategoryModel> categories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categoriesJson =
        categories.map((category) => json.encode(category.toMap())).toList();
    await prefs.setStringList(_expenseCategoriesKey, categoriesJson);
    print("---> Saved expense categories...");
  }

  static Future<void> removeCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_expenseCategoriesKey);
    print("---> removed expense Categories list");
    await prefs.remove(_incomeCategoriesKey);
    print("---> removed income Categories list");
  }

  static Future<List<CategoryModel>> loadExpenseCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJson = prefs.getStringList(_expenseCategoriesKey);
    if (categoriesJson == null) {
      return [];
    }
    return categoriesJson
        .map((categoryJson) => CategoryModel.fromMap(json.decode(categoryJson)))
        .toList();
  }

  static Future<void> saveExpenseCategory(CategoryModel category) async {
    List<CategoryModel> categories = await loadExpenseCategories();
    categories.add(category);
    await saveExpenseCategories(categories);
  }
}
