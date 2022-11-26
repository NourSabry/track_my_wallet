// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_element, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:track_my_wallet/models/transaction.dart';
import 'package:track_my_wallet/widgets/compose_transaction.dart';
import 'package:track_my_wallet/widgets/chart.dart';
import 'package:track_my_wallet/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Track My wallet App",
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _newTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      amount: amount,
      id: DateTime.now().toString(),
      date: chosenDate,
      title: title,
    );
    setState(() {
      _usertransactions.add(newTx);
    });
  }

  final List<Transaction> _usertransactions = [
    // Transaction(
    //   amount: 55.36,
    //   id: 1,
    //   time: DateTime.now(),
    //   title: "New shoes",
    // ),
    // Transaction(
    //   amount: 30.13,
    //   id: 2,
    //   time: DateTime.now(),
    //   title: "Weekly groceries",
    // ),
    // Transaction(
    //   amount: 15.15,
    //   id: 3,
    //   time: DateTime.now(),
    //   title: "New books",
    // )
  ];
  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (value) => NewTransaction(_newTransactions),
    );
  }

  List<Transaction> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track my wallet"),
        actions: [
          IconButton(
            onPressed: () {
              _startNewTransaction(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
            TransactionList(_usertransactions , _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
