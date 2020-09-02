import 'package:flutter/material.dart';

import 'enums/budget_page_state.dart';

class BudgetBaseModel extends ChangeNotifier {
  BudgetPageState _state = BudgetPageState.Idle;

  BudgetPageState get state => _state;

  void setState(BudgetPageState pageState) {
    _state = pageState;
    notifyListeners();
  }
}
