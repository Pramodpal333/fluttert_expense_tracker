import 'package:flutter/material.dart';

import '../../Models/Expenses.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem({super.key, required this.expense});
final ExpensesModel expense;
  @override
  Widget build(context){
    return Card(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.shade200,
      //       offset: Offset.fromDirection(30,-15,),
      //       blurRadius: 50,
      //       spreadRadius: 15
      //     )
      //   ]
      // ),
      // margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child:  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title,style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 4,),
          Row(
            children: [
              Text("₹ ${expense.amount.toStringAsFixed(2)}",style: Theme.of(context).textTheme.titleSmall,),
              const Spacer(),
              Row(
                children: [
                  Image.asset(categoryIcon[expense.category]!,width: 25,height: 25,),
                  const SizedBox(width: 2,),
                  Text("${expense.formatedDate}",style: Theme.of(context).textTheme.titleSmall,),
                  const SizedBox(width: 2,),

                ],
              ),

            ],
          )
        ],
      ),
    ));
  }
}