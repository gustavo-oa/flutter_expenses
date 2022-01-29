import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  void Function(String, double) addTransaction;
  TransactionForm(this.addTransaction);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    var value = double.parse(valueController.text);
    var title = titleController.text;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.addTransaction(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: "Titulo",
            ),
            onSubmitted: (_) => _submitForm(),
          ),
          TextField(
            controller: valueController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
            decoration: InputDecoration(
              labelText: "Valor (R\$)",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
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
