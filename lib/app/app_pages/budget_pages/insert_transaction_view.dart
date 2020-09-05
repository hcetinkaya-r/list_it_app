import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/models/budget/budget_category.dart';
import 'package:list_it_app/services/budget/budget_base_page.dart';
import 'package:list_it_app/view_models/budget/insert_transaction_model.dart';
import 'package:list_it_app/view_models/budget/ui_helper/ui_helpers.dart';

class InsertTransactionView extends StatelessWidget {
  final BudgetCategory category;
  final int selectedCategory;

  InsertTransactionView(this.category, this.selectedCategory);

  @override
  Widget build(BuildContext context) {
    return BudgetBasePage<InsertTransactionModel>(
      onModelReady: (model) => model.init(selectedCategory, category.index),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xFFA30003),
          ),
          title: selectedCategory == 1
              ? Text('Income', style: TextStyle(color: Color(0xFFA30003)))
              : Text(
                  'Expense',
                  style: TextStyle(color: Color(0xFFA30003)),
                ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xFFA30003),
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height/1.4,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30),
                  ListTile(
                    title: Text(
                      category.name + ":",
                      style: TextStyle(
                        color: Color(0xFFA30003),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          category.icon,
                          color: Color(0xFFA30003),
                          size: 20,
                        )),
                    contentPadding: EdgeInsets.only(left: 0),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  buildTextField(model.memoController, 'Title:',
                      "Enter a title", Icons.edit, false),
                  UIHelper.verticalSpaceMedium(),
                  buildTextField(model.amountController, 'Amount of money:',
                      "Enter an amount", Icons.monetization_on, true),
                  UIHelper.verticalSpaceMedium(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SELECT DATE:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFA30003)),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Color(0xFFA30003),
                  ),
                  Container(
                    width: 20,
                    height: 50,
                    child: RaisedButton(
                      child: Text(model.getSelectedDate()),
                      onPressed: () async {
                        await model.selectDate(context);
                      },
                    ),
                  ),
                  UIHelper.verticalSpaceLarge(),
                AppButton(
                  buttonText: "ADD",
                  buttonColor: Color(0xFFA30003),
                  textColor: Colors.white,
                  onPressed: () async {
                    await model.addTransaction(context);
                  },




                ),




                ],
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: 10,
              child: PageAvatar(

                avatarIcon: Icons.pie_chart_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Color(0xFFA30003),
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA30003))),
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Color(0xFFA30003),
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black54),
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        helperText: helperText,
      ),
    );
  }
}
