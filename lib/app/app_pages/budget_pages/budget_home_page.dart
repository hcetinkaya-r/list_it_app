import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/app/app_pages/budget_pages/chart_dialog_page.dart';
import 'package:list_it_app/app/sqflite_database/moor_database.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/budget/home_view_widgets/app_bar_title_widget.dart';
import 'package:list_it_app/common_widget/budget/home_view_widgets/budget_fab_widget.dart';
import 'package:list_it_app/common_widget/budget/home_view_widgets/empty_transaction_widget.dart';
import 'package:list_it_app/common_widget/budget/home_view_widgets/month_year_picker_widget.dart';
import 'package:list_it_app/common_widget/budget/home_view_widgets/summary_widget.dart';
import 'package:list_it_app/common_widget/budget/home_view_widgets/transactions_listview_widget.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/services/budget/budget_base_page.dart';
import 'package:list_it_app/services/budget/enums/budget_page_state.dart';
import 'package:list_it_app/view_models/budget/home_model.dart';
import 'package:list_it_app/view_models/budget/budget_router.dart';

class BudgetHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: BudgetRouters.generateRoute,
      home: BudgetBasePage<HomeModel>(
        onModelReady: (model) async => await model.init(),
        builder: (context, model, child) => Scaffold(
          appBar: buildAppBar(model.appBarTitle, model, context),
          floatingActionButton: Visibility(
            visible: model.show,
            child: Padding(
              padding: const EdgeInsets.only(right: 160, bottom: 30),
              child: BudgetFAB(model.closeMonthPicker),
            ),
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
                height: double.infinity,
                child: model.state == BudgetPageState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "Budget",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              SummaryWidget(
                                income: model.incomeSum,
                                expense: model.expenseSum,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: AppButton(
                                  buttonTextSize: 16,
                                  buttonText: "Look at the Budget Chart",
                                  buttonColor: Color(0xFFA30003),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              height: 800,
                                              child: ChartDialogPage(),
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                              buildList(model.transactions, model),
                            ],
                          ),
                          model.isCollapsed
                              ? PickMonthOverlay(
                                  model: model,
                                  showOrHide: model.isCollapsed,
                                  context: context)
                              : Container(),
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
      ),
    );
  }

  buildAppBar(String title, HomeModel model, context) {
    return AppBar(
      elevation: 0,


      iconTheme: IconThemeData(color: Color(0xFFA30003)),
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('assistant');
          },
          child: Icon(Icons.arrow_back_ios)),

      backgroundColor: Colors.transparent,


      //elevation: 0,
      title: AppBarTitle(

        title: title,
        model: model,
      ),
    );
  }

  buildList(List<Transaction> transactions, HomeModel model) {
    return transactions.length == 0
        ? EmptyTransactionsWidget()
        : TransactionsListView(transactions, model);
  }
}
