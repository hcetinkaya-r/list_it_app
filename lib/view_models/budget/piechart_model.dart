import 'package:list_it_app/app/sqflite_database/moor_database/moor_database.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/services/budget/budget_base_model.dart';
import 'package:list_it_app/services/budget/category_icon_service.dart';
import 'package:list_it_app/services/budget/enums/budget_page_state.dart';
import 'package:list_it_app/services/budget/moor_database_service.dart';

class PieChartModel extends BudgetBaseModel {
  List<String> months = [
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

  final MoorDatabaseService _moorDatabaseService =
      locator<MoorDatabaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  List<Transaction> transactions = List<Transaction>();

  int selectedMonthIndex = 0;

  Map<String, double> dataMap = new Map<String, double>();

  String type = 'expense';

  List<String> types = ["Income", "Expense"];

  init(bool firstTime) async {
    if (firstTime) selectedMonthIndex = DateTime.now().month - 1;

    setState(BudgetPageState.Busy);
    notifyListeners();

    transactions = await _moorDatabaseService.getAllTransactionsForType(
        months.elementAt(selectedMonthIndex), type);

    dataMap = getDefaultDataMap(transactions);

    transactions.forEach((element) {
      prepareDataMap(element);
    });

    print(dataMap.toString());

    setState(BudgetPageState.Idle);
    notifyListeners();
  }

  changeSelectedMonth(int val) async {
    selectedMonthIndex = val;

    transactions = await _moorDatabaseService.getAllTransactionsForType(
        months.elementAt(selectedMonthIndex), type);
    // clear old data
    dataMap = getDefaultDataMap(transactions);

    transactions.forEach((element) {
      prepareDataMap(element);
    });

    notifyListeners();
  }

  Map<String, double> getDefaultDataMap(List<Transaction> transactions) {
    Map<String, double> fullExpensesMap = {
      'Food': 0,
      'Bills': 0,
      'Transportation': 0,
      'Home': 0,
      'Entertainment': 0,
      'Shopping': 0,
      'Clothing': 0,
      'Insurance': 0,
      'Telephone': 0,
      'Health': 0,
      'Sport': 0,
      'Beauty': 0,
      'Education': 0,
      'Gift': 0,
      'Pet': 0,
      'Salary': 0,
      'Awards': 0,
      'Grants': 0,
      'Rental': 0,
      'Investment': 0,
      'Lottery': 0,
      'Hobby': 0,
    };

    Map<String, double> fullIncomeMap = {
      'Salary': 0,
      'Awards': 0,
      'Grants': 0,
      'Rental': 0,
      'Investment': 0,
      'Lottery': 0,
      'Business': 0,
    };

    List<String> transactionsCategories = List();

    transactions.forEach((element) {
      if (type == 'income') {
        String category = _categoryIconService.incomeList
            .elementAt(element.categoryindex)
            .name;
        transactionsCategories.add(category);
      } else {
        String category = _categoryIconService.expenseList
            .elementAt(element.categoryindex)
            .name;
        transactionsCategories.add(category);
      }
    });

    if (type == 'income') {
      fullIncomeMap.removeWhere((key, value) {
        return !transactionsCategories.contains(key);
      });
      return fullIncomeMap;
    }

    fullExpensesMap.removeWhere((key, value) {
      return !transactionsCategories.contains(key);
    });

    return fullExpensesMap;
  }

  changeType(int val) async {
    if (val == 0) {
      type = 'income';
    } else {
      type = 'expense';
    }

    await init(false);
  }

  void prepareDataMap(element) {
    if (type == 'income') {
      dataMap[_categoryIconService.incomeList
          .elementAt(element.categoryindex)
          .name] = dataMap[_categoryIconService.incomeList
              .elementAt(element.categoryindex)
              .name] +
          element.amount;
    } else {
      dataMap[_categoryIconService.expenseList
          .elementAt(element.categoryindex)
          .name] = dataMap[_categoryIconService.expenseList
              .elementAt(element.categoryindex)
              .name] +
          element.amount;
    }
  }
}
