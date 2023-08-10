import 'package:flutter/material.dart';
import 'package:fluttert_expense_tracker/Models/Expenses.dart';
import 'package:fluttert_expense_tracker/main.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key,required this.onAddExpense}) : super(key: key);
  final void Function(ExpensesModel exp) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController amountCon = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    titleCon.dispose();
    amountCon.dispose();
    super.dispose();
  }

  _presentDatePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10,50,10,keyboard +10),
          child: Column(
            children: [
              TextFormField(
                controller: titleCon,
                maxLength: 20,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                style: TextStyle(color: kColorScheme.onBackground,fontWeight: FontWeight.w400,),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: amountCon,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text("Amount"), prefixText: "₹ "
                      ),
                      style :TextStyle(color: kColorScheme.onBackground,fontWeight: FontWeight.w400,),
                    ),

                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? "selected Date"
                            : formatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ],
              ),
SizedBox(height: 15,),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) =>
                          DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase(), style :TextStyle(color: kColorScheme.onBackground,fontWeight: FontWeight.w400,),))
                      )
                          .toList(),
                      onChanged: (value) {
                        if(value != null){
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      }),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed:_saveExpense, child:  Text("Save Expense",style: Theme.of(context).textTheme.titleSmall,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveExpense() {
    var amt = double.tryParse(amountCon.text.trim());
    var invalidAmt = amt == null || amt <= 0;
    if(titleCon.text.trim().isEmpty || invalidAmt || _selectedDate == null){
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: Text("Invalid Input"),
        content: Text("Please enter valid title date and amount"),
        actions: [
          TextButton(onPressed: (){Navigator.pop(ctx);}, child: Text("Ok")),
        ],
      ));
      return;
    }
    widget.onAddExpense(ExpensesModel(title: titleCon.text.trim(), amount: amt.toDouble(), date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }
}
