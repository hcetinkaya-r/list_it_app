import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_it_app/app/sqflite_database/moor_database.dart';



class DetailsTable extends StatelessWidget {
  const DetailsTable({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Table(

      columnWidths: {1: FixedColumnWidth(250)},
      children: [
        TableRow(
          children: [
            Text(
              "Category: ",
              style: TextStyle(
                color: Color(0xFFA30003),

                fontSize: 18,

              ),
            ),
            Text(
              transaction.type,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Money: ",
              style: TextStyle(
                color: Color(0xFFA30003),

                fontSize: 18,
              ),
            ),
            Text(
              transaction.amount.toString(),
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                  color: Colors.black54
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Date: ",
              style: TextStyle(
                color: Color(0xFFA30003),
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.day + ", " + transaction.month,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                  color: Colors.black54
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Title: ",
              style: TextStyle(
                color: Color(0xFFA30003),

                fontSize: 18,
              ),
            ),
            Text(
              transaction.memo,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                  color: Colors.black54
              ),
            ),
          ],
        ),
      ],
    );
  }
}
