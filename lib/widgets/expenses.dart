import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spendwise/data/database.dart';
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
  final _mybox = Hive.box("spendwise");
  SpendwiseDatabase db = SpendwiseDatabase();

  @override
  void initState() {
    if (_mybox.get("expenses") == null) {
      print("Yes");
      db.createInitialList();
    } else {
      print("No");
      db.loadData();
    }

    super.initState();
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
      isScrollControlled: true,
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      db.registeredExpenses.add(expense);
    });
    db.updateData();
  }

  void _removeExpense(Expense expense) {
    var expenseIndex = db.registeredExpenses.indexOf(expense);
    setState(() {
      db.registeredExpenses.remove(expense);
    });
    db.updateData();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              db.registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = db.registeredExpenses.isNotEmpty
        ? ExpensesList(
            expenses: db.registeredExpenses,
            removeExpense: _removeExpense,
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Start Adding Some Expenses',
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white38,
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
          Chart(expenses: db.registeredExpenses),
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
