import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});

  final double fill;

  @override
  Widget build(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
