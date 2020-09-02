
import 'package:flutter/material.dart';
import 'package:list_it_app/app/sqflite_database/moor_database/moor_database.dart';
import 'package:list_it_app/common_widget/budget/details_view_widgets/details_table.dart';
import 'package:list_it_app/view_models/budget/details_model.dart';
import 'package:list_it_app/view_models/budget/ui_helper/ui_helpers.dart';


class DetailsCard extends StatelessWidget {
  final Transaction transaction;
  final DetailsModel model;
  DetailsCard({this.transaction, this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
    
        child: Column(
          children: <Widget>[
            ListTile(

              contentPadding: EdgeInsets.all(0),
              trailing: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: model.getIconForCategory(
                      transaction.categoryindex, transaction.type)),
              title: Text(
                "\t\t\t" +
                    model.getCategoryIconName(
                        transaction.categoryindex, transaction.type),
                style: TextStyle(fontSize: 30, color: Colors.black54),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            UIHelper.verticalSpaceSmall(),
            DetailsTable(transaction: transaction),
          ],
        ),
      ),
    );
  }
}
