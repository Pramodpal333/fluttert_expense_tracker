import 'package:flutter/material.dart';
import 'package:fluttert_expense_tracker/ImagesPath.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

var formatter = DateFormat.yMd();
var uuid = const Uuid();

enum Category { bill, food, travel, entertainment, cloth, lending, others }

const categoryIcon = {
  Category.food: food_icon,
  Category.travel: travel_icon,
  Category.entertainment: fun_icon,
  Category.bill: bill_icon,
  Category.cloth: cloths_icon,
  Category.lending: lending_icon,
  Category.others: other_icon,
};

class ExpensesModel {
  ExpensesModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<ExpensesModel> expenses;

  ExpenseBucket.forCategory(List<ExpensesModel> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
