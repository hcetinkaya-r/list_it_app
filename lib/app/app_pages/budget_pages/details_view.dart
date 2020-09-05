import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/app/sqflite_database/moor_database.dart';
import 'package:list_it_app/common_widget/budget/details_view_widgets/details_card.dart';
import 'package:list_it_app/services/budget/budget_base_page.dart';
import 'package:list_it_app/view_models/budget/details_model.dart';

class DetailsView extends StatelessWidget {
  final Transaction transaction;

  DetailsView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BudgetBasePage<DetailsModel>(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushReplacementNamed('home');

          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFFA30003)),
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('home');
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.delete),
                  onTap: () {
                    showDeleteDialog(context, model);
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(10.0),
                child: DetailsCard(
                  transaction: transaction,
                  model: model,
                ),
              ),
              Positioned(
                right: 25,
                top: 220,
                child: FloatingActionButton(
                  child: Icon(Icons.edit, color: Colors.white),
                  backgroundColor: Color(0xFFA30003),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('edit', arguments: transaction);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showDeleteDialog(BuildContext context, DetailsModel model) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Delete",
              style: TextStyle(
                color: Color(0xFFA30003),
              ),
            ),
            content:
                Text("Are you sure do you want to delete this transaction?"),
            actions: <Widget>[
              FlatButton(
                color: Color(0xFFA30003),
                child: Text(
                  "Delete",
                ),
                onPressed: () async {
                  await model.deleteTransaction(transaction);
                  Navigator.pop(context);

                 /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BudgetHomePage()));*/
                },
              ),
              FlatButton(
                color: Colors.grey,
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }
}
