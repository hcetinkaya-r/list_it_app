import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TransactionTypeSpinner extends StatelessWidget {
  final selectedItem;
  final Function changedSelectedItem;
  const TransactionTypeSpinner(this.selectedItem, this.changedSelectedItem);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
      iconEnabledColor: Color(0xFFA30003),

        value: selectedItem,
        items: [
          DropdownMenuItem(
            child: Text("Income"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("Expense"),
            value: 2,
          ),
        ],
        onChanged: (value) {
          changedSelectedItem(value);
        });
  }
}
