import 'package:flutter/material.dart';
import 'package:list_it_app/app/sqflite_database/moor_database/moor_database.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/services/budget/budget_base_model.dart';
import 'package:list_it_app/services/budget/category_icon_service.dart';
import 'package:list_it_app/services/budget/moor_database_service.dart';

class DetailsModel extends BudgetBaseModel {
  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  final MoorDatabaseService _moorDatabaseService =
      locator<MoorDatabaseService>();

  Icon getIconForCategory(int index, String type) {
    if (type == 'income') {
      final categoryIcon = _categoryIconService.incomeList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    } else {
      final categoryIcon = _categoryIconService.expenseList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    }
  }

  String getCategoryIconName(index, type) {
    if (type == 'income') {
      return _categoryIconService.incomeList.elementAt(index).name;
    } else {
      return _categoryIconService.expenseList.elementAt(index).name;
    }
  }

  Future deleteTransaction(Transaction transaction) async {
    return await _moorDatabaseService.deleteTransaction(transaction);
  }
}
