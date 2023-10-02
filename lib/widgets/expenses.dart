import 'package:flutter/material.dart';
import 'package:spendwise/widgets/expenses_list/expenses_list.dart';
import 'package:spendwise/models/expense.dart';
import 'package:spendwise/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Burger',
      amount: 29.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Flutter Course 3',
      amount: 100,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
      isScrollControlled: true,
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(context) {
    Widget mainContent = _registeredExpenses.isNotEmpty
        ? ExpensesList(
            expenses: _registeredExpenses,
            removeExpense: _removeExpense,
          )
        : const Center(
            child: Text('Start Adding Some Expenses'),
          );

    print('Registered expenses length: ${_registeredExpenses.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spendwise'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
