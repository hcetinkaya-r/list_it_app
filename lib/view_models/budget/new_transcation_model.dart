

import 'package:list_it_app/locator.dart';
import 'package:list_it_app/models/budget/budget_category.dart';
import 'package:list_it_app/services/budget/budget_base_model.dart';
import 'package:list_it_app/services/budget/category_icon_service.dart';

class NewTransactionModel extends BudgetBaseModel {
  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  int selectedCategory = 2; // 1 = income, 2 = expense

  void changeSelectedItem(int newItemIndex) {
    selectedCategory = newItemIndex;

    notifyListeners();
  }

  List<BudgetCategory> loadCategoriesIcons() {
    if (selectedCategory == 1) {

      List<BudgetCategory> s = _categoryIconService.incomeList.toList();
      return s;
    } else {

      List<BudgetCategory> s = _categoryIconService.expenseList.toList();
      return s;
    }
  }
}
