import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/models/category.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
part 'expense.g.dart';


final formatter = DateFormat.yMd();

const uuid = Uuid();

const categoryIcon = {
  Category.food: Icons.dining_rounded,
  Category.leisure: Icons.bedroom_parent_rounded,
  Category.stationary: Icons.book,
  Category.travel: Icons.flight_land_rounded,
  Category.work: Icons.work
};

@HiveType(typeId: 2)
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;
  
  
  @HiveField(2)
  final double amount;
  
  
  @HiveField(3)
  final DateTime date;
  
  
  @HiveField(4)
  final Category category;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
