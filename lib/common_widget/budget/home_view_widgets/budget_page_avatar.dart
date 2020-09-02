import 'package:flutter/material.dart';


class BudgetPageAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Positioned(
      left: MediaQuery.of(context).size.width / 2.38,
      top: MediaQuery.of(context).size.height / 90,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xFFA30003)),
        ),
        child: Icon(
          Icons.pie_chart_outlined,
          size: 55,
          color: Color(0xFFA30003),
        ),
      ),
    );
  }
}
