import 'package:flutter/material.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/services/budget/budget_base_model.dart';
import 'package:provider/provider.dart';

class BudgetBasePage<T extends BudgetBaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BudgetBasePage({this.builder, this.onModelReady});

  @override
  _BudgetBasePageState<T> createState() => _BudgetBasePageState<T>();
}

class _BudgetBasePageState<T extends BudgetBaseModel>
    extends State<BudgetBasePage<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}
