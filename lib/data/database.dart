import 'package:hive_flutter/hive_flutter.dart';
import 'package:spendwise/models/category.dart';
import 'package:spendwise/models/expense.dart';

class SpendwiseDatabase {
  final _mybox = Hive.box("spendwise");

  List<Expense> registeredExpenses = [];

  void createInitialList() {
    registeredExpenses = [
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
  }

  void loadData() {
    var loadedData = _mybox.get("expenses");
    if (loadedData != null && loadedData is List) {
      registeredExpenses = loadedData.cast<Expense>();
    } else {
      registeredExpenses = [];
    }
  }

  void updateData() {
    print("update started");
    _mybox.put("expenses", registeredExpenses);
    print("updated");
  }
}
