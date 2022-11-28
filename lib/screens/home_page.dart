// ignore_for_file: use_key_in_widget_constructors
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_my_wallet/models/transaction.dart';
import 'package:track_my_wallet/widgets/compose_transaction.dart';
import 'package:track_my_wallet/widgets/chart.dart';
import 'package:track_my_wallet/widgets/transaction_list.dart';

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

  final List<Transaction> _usertransactions = [];
  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (value) => NewTransaction(_newTransactions),
    );
  }

  bool _showChart = false;

  void toggleSwitch(bool value) {
    if (_showChart == false) {
      setState(() {
        _showChart = true;
      });
    } else {
      setState(() {
        _showChart = false;
      });
    }
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
    //textScaleFactor is equal to 1, so it would change automatically when the user adjust the font Size with his own way
    final mediaQuery = MediaQuery.of(context);
    final textSaleFactor = mediaQuery.textScaleFactor;
    final isLandScabe = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Track My Wallet',
              style: TextStyle(fontSize: 20 * textSaleFactor),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Track My Wallet',
              style: TextStyle(fontSize: 20 * textSaleFactor),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startNewTransaction(context),
              ),
            ],
          );
    final txsList = SizedBox(
      height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.75,
      child: TransactionList(_usertransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isLandScabe)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show Chart"),
                  Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _showChart,
                    onChanged: toggleSwitch,
                  ),
                ],
              ),
            if (!isLandScabe)
              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions),
                ),
              ),
            if (!isLandScabe) txsList,
            if (isLandScabe)
              _showChart
                  ? SizedBox(
                      width: double.infinity,
                      child: SizedBox(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(_recentTransactions),
                      ),
                    )
                  : txsList,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      _startNewTransaction(context);
                    },
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
