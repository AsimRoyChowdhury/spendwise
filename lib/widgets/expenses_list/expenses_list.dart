import 'package:flutter/material.dart';
import 'package:spendwise/models/expense.dart';
import 'package:spendwise/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: const Color.fromARGB(173, 244, 67, 54),
          margin: EdgeInsets.zero,
        ),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
