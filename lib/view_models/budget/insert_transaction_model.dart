import 'package:flutter/material.dart';
import 'package:list_it_app/app/sqflite_database/moor_database.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/services/budget/budget_base_model.dart';
import 'package:list_it_app/services/budget/moor_database_service.dart';
import 'package:toast/toast.dart';

class InsertTransactionModel extends BudgetBaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final MoorDatabaseService _moorDatabaseService =
      locator<MoorDatabaseService>();

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

  String selectedDay;
  String selectedMonth;
  DateTime selectedDate = new DateTime.now();
  String type;
  int categoryIndex;

  Future selectDate(context) async {
    unFocusFromTheTextField(context);

    DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void init(int selectedCategory, int index) {
    selectedMonth = months[DateTime.now().month - 1];
    selectedDay = DateTime.now().day.toString();
    type = (selectedCategory == 1) ? 'income' : 'expense';
    categoryIndex = index;
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Today ' + selectedMonth + ',' + selectedDay;
    } else {
      return selectedMonth + ',' + selectedDay;
    }
  }

  addTransaction(context) async {
    String memo = memoController.text;
    String amount = amountController.text;

    if (memo.length == 0 || amount.length == 0) {
      Toast.show("Please fill all fields!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    Transaction newTransaction = new Transaction(
        type: type,
        day: selectedDay,
        month: selectedMonth,
        memo: memoController.text,
        amount: int.parse(amount),
        categoryindex: categoryIndex);

    await _moorDatabaseService.insertTransaction(newTransaction);

    Toast.show("Added successfully!", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
  }
}
