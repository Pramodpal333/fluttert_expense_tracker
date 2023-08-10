import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttert_expense_tracker/Widgets/ExpensesList/ExpenseItem.dart';
import 'package:fluttert_expense_tracker/Widgets/ExpensesList/ExpensesList.dart';
import 'package:fluttert_expense_tracker/Widgets/NewExpense/NewExpense.dart';

import '../Models/Expenses.dart';
import 'chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<ExpensesModel> expensesList = [
    ExpensesModel(
        title: "Food",
        amount: 150,
        date: DateTime.now(),
        category: Category.food),
    ExpensesModel(
        title: "Bowling",
        amount: 1000,
        date: DateTime.now(),
        category: Category.entertainment),
  ];

  void _openModel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: onAddExpense,
            ));
  }

  void onAddExpense(ExpensesModel exp) {
    setState(() {
      expensesList.add(exp);
    });
  }

  onRemoveExpense(ExpensesModel exp) {
    var index = expensesList.indexOf(exp);
    setState(() {
      expensesList.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    // show undo message
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
        content: Text("Expense Deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: (){
          setState(() {
            expensesList.insert(index, exp);
          });
        },
      ),
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Widget mainContent = Center(child: Text("No Expenses"));
    if (expensesList.isNotEmpty) {
      mainContent =  width < 600 ?Column(
        children: [
          Chart(expenses: expensesList,),
          Expanded(
              child: ExpensesList(
            expensesList: expensesList,
            onRemoveExpense: onRemoveExpense,
          ))
        ],
      ) : Row(children: [
        Expanded(child: Chart(expenses: expensesList,)),
        Expanded(
            child: ExpensesList(
              expensesList: expensesList,
              onRemoveExpense: onRemoveExpense,
            ))
      ],);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses Tracker',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _openModel();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: mainContent,
    );
  }
}
