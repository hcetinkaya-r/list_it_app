
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/common_widget/budget/new_transaction_view_widget/transaction_type_spinner.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/services/budget/budget_base_page.dart';
import 'package:list_it_app/view_models/budget/new_transcation_model.dart';
import 'package:list_it_app/view_models/budget/ui_helper/ui_helpers.dart';

class NewTransactionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BudgetBasePage<NewTransactionModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFFA30003)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TransactionTypeSpinner(
              model.selectedCategory, model.changeSelectedItem),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xFFA30003),
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height/1.3,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                children: model
                    .loadCategoriesIcons()
                    .map(
                      (e) => Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("insertTransaction", arguments: [e, model.selectedCategory]);

                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Center(
                                    child: Icon(
                                      e.icon,
                                      size: 20,
                                      color: Color(0xFFA30003),

                                    ),
                                  ),
                                ),
                                Text(
                                  e.name,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                UIHelper.verticalSpaceLarge(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: 10,

                child: PageAvatar(
                  avatarIcon: Icons.pie_chart_outlined,

                )),
          ],
        ),
      ),
    );
  }
}
