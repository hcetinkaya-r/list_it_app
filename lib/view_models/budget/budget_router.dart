import 'package:flutter/material.dart';
import 'package:list_it_app/app/app_page/assistant_page.dart';
import 'package:list_it_app/app/app_page/budget_pages/budget_home_page.dart';
import 'package:list_it_app/app/app_page/budget_pages/details_view.dart';
import 'package:list_it_app/app/app_page/budget_pages/edit_view.dart';
import 'package:list_it_app/app/app_page/budget_pages/insert_transaction_view.dart';
import 'package:list_it_app/app/app_page/budget_pages/new_transaction_view.dart';
import 'package:list_it_app/app/app_page/budget_pages/piechart_view.dart';
import 'package:list_it_app/app/sqflite_database/moor_database.dart';

class BudgetRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'assistant':
        return MaterialPageRoute(builder: (context) => AssistantPage());
      case 'home':
        return MaterialPageRoute(builder: (_) => BudgetHomePage());
      case 'edit':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(fullscreenDialog: true, builder: (_) => EditView(transaction));
      case 'chart':
        return MaterialPageRoute(builder: (_) => PieChartView());
      case 'newTransaction':
        return MaterialPageRoute(fullscreenDialog: true,builder: (_) => NewTransactionView());
      case 'insertTransaction':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                InsertTranscationView(args.elementAt(0), args.elementAt(1)));
      case 'details':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(builder: (_) => DetailsView(transaction));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
