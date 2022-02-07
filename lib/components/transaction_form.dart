import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_button.dart';
import 'adaptative_datepicker.dart';
import 'adaptavite_textfield.dart';

class TransactionForm extends StatefulWidget {
  void Function(String, double, DateTime) addTransaction;

  TransactionForm(this.addTransaction);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  late DateTime? _selectedDate = null;

  _submitForm() {
    var value = double.parse(_valueController.text);
    var title = _titleController.text;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.addTransaction(
      title,
      value,
      _selectedDate == null ? DateTime.now() : _selectedDate!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: [
            AdaptativeTextField(
              label: "Titulo",
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
            ),
            AdaptativeTextField(
              label: "Valor (R\$)",
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
            ),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                  label: "Nova Transação",
                  onPressed: _submitForm,
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
