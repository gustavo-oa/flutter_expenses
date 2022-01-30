import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: "Titulo",
            ),
            onSubmitted: (_) => _submitForm(),
          ),
          TextField(
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
            decoration: const InputDecoration(
              labelText: "Valor (R\$)",
            ),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data selecionada: ${DateFormat('d/M/y').format(_selectedDate!)}',
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Selecionar Data"),
                  onPressed: _showDatePicker,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).textTheme.button?.color,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text("Nova Transação"),
                onPressed: _submitForm,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
