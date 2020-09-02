
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BudgetFAB extends StatelessWidget {
  final Function closeMonthPicker;


  const BudgetFAB(this.closeMonthPicker);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        closeMonthPicker();
        Navigator.of(context).pushNamed("newTransaction");

      },
      backgroundColor: Colors.white,
      child: Icon(
        Icons.add_circle_outline,
        color: Color(0xFFA30003),
        size: 40,
      ),
    );


  }
}
