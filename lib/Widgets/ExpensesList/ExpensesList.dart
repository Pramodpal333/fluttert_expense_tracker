import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttert_expense_tracker/Models/Expenses.dart';
import 'package:fluttert_expense_tracker/Widgets/ExpensesList/ExpenseItem.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {super.key, required this.expensesList, required this.onRemoveExpense});

  final List<ExpensesModel> expensesList;
  final void Function(ExpensesModel exp) onRemoveExpense;
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 50);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        itemCount: expensesList.length,
        itemBuilder: (context, index) {
          var trx = expensesList[index];
          var date = trx.date;
          // var showLine = false;
          // if(expensesList.isNotEmpty && expensesList.length > 1){
          //  var previosDate = expensesList[index -1].date;
          //  showLine = date.isAfter(previosDate);
          // }
          return Dismissible(
              key: ValueKey(trx),
              background: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(12),
                  )),
              onDismissed: (direction) {
                onRemoveExpense(trx);
              },
              child: ExpenseItem(expense: trx));
        });
  }
}
