
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_it_app/models/budget/budget_category.dart';


class CategoryIconService {
  final expenseList = {
    BudgetCategory(0, "Food", FontAwesomeIcons.pizzaSlice, Colors.green),
    BudgetCategory(1, "Bills", FontAwesomeIcons.moneyBill, Colors.blue),
    BudgetCategory(2, "Transportation", FontAwesomeIcons.bus, Colors.blueAccent),
    BudgetCategory(3, "Home", FontAwesomeIcons.home, Colors.brown),
    BudgetCategory(4, "Entertainment", FontAwesomeIcons.gamepad, Colors.cyanAccent),
    BudgetCategory(5, "Shopping", FontAwesomeIcons.shoppingBag, Colors.deepOrange),
    BudgetCategory(6, "Clothing", FontAwesomeIcons.tshirt, Colors.deepOrangeAccent),
    BudgetCategory(7, "Insurance", FontAwesomeIcons.hammer, Colors.indigo),
    BudgetCategory(8, "Telephone", FontAwesomeIcons.phone, Colors.indigoAccent),
    BudgetCategory(9, "Health", FontAwesomeIcons.briefcaseMedical, Colors.lime),
    BudgetCategory(10, "Sport", FontAwesomeIcons.footballBall, Colors.limeAccent),
    BudgetCategory(11, "Beauty", FontAwesomeIcons.marker, Colors.pink),
    BudgetCategory(12, "Education", FontAwesomeIcons.book, Colors.teal),
    BudgetCategory(13, "Gift", FontAwesomeIcons.gift, Colors.redAccent),
    BudgetCategory(14, "Pet", FontAwesomeIcons.dog, Colors.deepPurpleAccent),
    BudgetCategory(15, "Hobby", FontAwesomeIcons.fan, Colors.black54),


  };

  final incomeList = {
    BudgetCategory(0, "Salary", FontAwesomeIcons.wallet, Colors.green),
    BudgetCategory(1, "Awards", FontAwesomeIcons.moneyCheck, Colors.amber),
    BudgetCategory(2, "Grants", FontAwesomeIcons.gifts, Colors.lightGreen),
    BudgetCategory(3, "Rental", FontAwesomeIcons.houseUser, Colors.yellow),
    BudgetCategory(4, "Investment", FontAwesomeIcons.piggyBank, Colors.cyanAccent),
    BudgetCategory(5, "Lottery", FontAwesomeIcons.dice, Colors.deepOrange),
    BudgetCategory(6, "Business", FontAwesomeIcons.businessTime, Colors.grey),
    BudgetCategory(7, "Commission", FontAwesomeIcons.moneyCheckAlt, Colors.orange),



  };
}
