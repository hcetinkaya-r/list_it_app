
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:list_it_app/app/sqflite_database/moor_database.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/services/budget/budget_base_page.dart';
import 'package:list_it_app/view_models/budget/edit_model.dart';
import 'package:list_it_app/view_models/budget/ui_helper/ui_helpers.dart';

class EditView extends StatelessWidget {
  final Transaction transaction;

  EditView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BudgetBasePage<EditModel>(
      onModelReady: (model) => model.init(transaction),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFFA30003)),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/1.4,
              margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xFFA30003),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 30),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          model.category.icon,
                          size: 20,
                          color: Color(0xFFA30003),
                        ),
                      ),
                      title: Text(
                        model.category.name + ":",
                        style: TextStyle(
                            color: Color(0xFFA30003),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    buildTextField(model.memoController, 'Title:',
                        "Enter a title", Icons.edit, false),
                    UIHelper.verticalSpaceMedium(),
                    buildTextField(
                        model.amountController,
                        'Amount:',
                        "Enter an amount",
                        Icons.attach_money,
                        true),
                    UIHelper.verticalSpaceMedium(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'SELECT DATE:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFA30003),),
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
                    buttonText: "EDIT",
                     textColor: Colors.white,
                     buttonColor: Color(0xFFA30003),

                     onPressed: () async {
              await model.editTransaction(context, transaction.type,
              transaction.categoryindex, transaction.id);
              },


                ),

                  ],
                ),
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

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Color(0xFFA30003),
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Color(0xFFA30003),
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
