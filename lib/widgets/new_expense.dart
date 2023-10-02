import 'package:flutter/material.dart';
import 'package:spendwise/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});
  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(2000, 1, 1);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount! <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter correct Title, Amount and Date'),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      widget.addExpense(Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    prefixText: '₹ ',
                    label: Text('Amount'),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 120,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Add Date'
                        : formatter.format(_selectedDate!),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.date_range_rounded),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const Spacer(),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.redAccent),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
