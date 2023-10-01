import 'package:flutter/material.dart';
import 'package:spendwise/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₹ ${expense.amount.toStringAsFixed(2)}'),
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(width: 5,),
                    Text(expense.formatedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}