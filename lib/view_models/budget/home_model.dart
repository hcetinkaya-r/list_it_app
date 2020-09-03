import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_it_app/app/sqflite_database/moor_database.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/services/budget/budget_base_model.dart';
import 'package:list_it_app/services/budget/category_icon_service.dart';
import 'package:list_it_app/services/budget/enums/budget_page_state.dart';
import 'package:list_it_app/services/budget/moor_database_service.dart';

class HomeModel extends BudgetBaseModel {
  final MoorDatabaseService _moorDatabaseService =
      locator<MoorDatabaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  ScrollController scrollController =
      new ScrollController(); // set controller on scrolling
  bool show = true;

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<Transaction> transactions = List<Transaction>();
  bool isCollapsed = false;
  String appBarTitle; // selected month
  String selectedYear;
  int selectedMonthIndex; // from month list above

  int expenseSum = 0;
  int incomeSum = 0;

  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);
    appBarTitle = clickedMonth;
    transactions = await _moorDatabaseService.getAllTransactions(appBarTitle);
    expenseSum = await _moorDatabaseService.getExpenseSum(appBarTitle);
    incomeSum = await _moorDatabaseService.getIncomeSum(appBarTitle);
    titleClicked();
  }

  titleClicked() {
    isCollapsed = !isCollapsed;
    notifyListeners();
  }

  getColor(month) {
    int monthIndex = months.indexOf(month);
    // color the selected month with
    if (monthIndex == selectedMonthIndex) {
      return Color(0xFFA30003);
    } else {
      return Colors.black54;
    }
  }

  void closeMonthPicker() {
    isCollapsed = false;
    notifyListeners();
  }

  init() async {
    handleScroll();

    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[selectedMonthIndex];

    expenseSum = await _moorDatabaseService.getExpenseSum(appBarTitle);
    incomeSum = await _moorDatabaseService.getIncomeSum(appBarTitle);

    print("Expense : $expenseSum");
    print("Income : $incomeSum");

    setState(BudgetPageState.Busy);
    notifyListeners();

    transactions = await _moorDatabaseService.getAllTransactions(appBarTitle);

    setState(BudgetPageState.Idle);
    notifyListeners();
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloatingButton();
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloatingButton();
      }
    });
  }

  void showFloatingButton() {
    show = true;
    notifyListeners();
  }

  void hideFloatingButton() {
    show = false;
    notifyListeners();
  }

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
}
