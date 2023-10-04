import 'package:flutter/material.dart';
import 'package:spendwise/widgets/expenses.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 61, 51, 132),
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 47, 45, 65),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 58, 54, 111),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        cardTheme: const CardTheme().copyWith(
          color: const Color.fromARGB(255, 80, 76, 110),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 8,
          shadowColor: const Color.fromARGB(255, 2, 2, 2),
        ),
        bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: const Color.fromARGB(255, 129, 123, 181),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
