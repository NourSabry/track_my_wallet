// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_my_wallet/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: [
                Text(
                  "No Transactions added yet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.05,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: ((context, index) => Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date!),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            onPressed: () => deleteTx(transactions[index].id!),
                            label: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            icon: const Icon(Icons.delete),
                          )
                        : IconButton(
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id!),
                            icon: const Icon(Icons.delete),
                          ),
                  ),
                )),
            itemCount: transactions.length,
          );
  }
}
