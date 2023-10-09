import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendwise/widgets/chart/chart.dart';
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
    var expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = _registeredExpenses.isNotEmpty
        ? ExpensesList(
            expenses: _registeredExpenses,
            removeExpense: _removeExpense,
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Start Adding Some Expenses',
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spendwise'.toUpperCase(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        // actions: [

        // ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: 80,
        color: const Color.fromARGB(255, 60, 56, 116),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.settings, color: Colors.white, size: 35),
                  Text(
                    'Settings',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.credit_card, color: Colors.white, size: 35),
                  Text(
                    'Add Credit',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 47, 45, 65), shape: BoxShape.circle),
        height: 100,
        width: 100,
        child: Container(
          decoration:
              const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          height: 80,
          width: 80,
          child: IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add, color: Colors.white, size: 40),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
