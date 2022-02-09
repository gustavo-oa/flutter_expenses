import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  void Function(String id) onRemove;
  TransactionList({
    required this.transactions,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma transação cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets\\images\\waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions.map(
              (tr) {
                return TransactionItem(
                  key: Key(tr.id),
                  tr: tr,
                  onRemove: onRemove,
                );
              },
            ).toList(),
          );
    // ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (ctx, index) {
    //       final tr = transactions[index];
    //       return TransactionItem(
    //         key: GlobalObjectKey(tr.id),
    //         tr: tr,
    //         onRemove: onRemove,
    //       );
    //     },
    //   );
  }
}
