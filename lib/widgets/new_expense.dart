import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        enteredAmount <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 65, 60, 126),
          title: Text(
            'Invalid Input',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Please enter correct Title, Amount and Date',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Okay',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
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
      padding: const EdgeInsets.fromLTRB(25, 100, 25, 16),
      child: Column(
        children: [
          TextField(
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              prefix: const Text(
                ' ',
                style: TextStyle(fontSize: 30),
              ),
              filled: true,
              fillColor: const Color.fromARGB(126, 248, 247, 247),
              counterStyle: GoogleFonts.poppins(
                color: const Color.fromARGB(150, 255, 255, 255),
              ),
              // enabledBorder: InputBorder.none,
              // focusedBorder: InputBorder.none,
              label: Text(
                ' Title',
                style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    height: 0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixText: '₹ ',
                    label: Text(
                      'Amount',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(126, 248, 247, 247),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Add Date'
                        : formatter.format(_selectedDate!),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(202, 255, 255, 255),
                        fontSize: 20),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.date_range_rounded,
                        color: Color.fromARGB(255, 253, 252, 252), size: 30),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton(
                dropdownColor: Color.fromARGB(255, 255, 255, 255),
                iconSize: 30,
                iconEnabledColor: Colors.white54,
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 239, 67, 55),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: _submitForm,
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
