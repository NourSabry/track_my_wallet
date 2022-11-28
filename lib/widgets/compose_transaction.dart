// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_my_wallet/widgets/adaptive_flat_button.dart';
import 'package:track_my_wallet/widgets/customized_elevated_butoon.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction(this.newtx);
  final Function newtx;
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newtx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
  }

  void _presentDatePicker() {
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
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "title"),
                controller: _titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "amount"),
                controller: _amountController,
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? "No date chosen yet"
                        : 'picked date is: ${DateFormat.yMd().format(_selectedDate!)}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  AdaptiveFlatButton(
                    'Choose Date',
                    _presentDatePicker,
                  ),
                ],
              ),
              CustomizedElevatedButton(
                onPressed: submitData,
                title: "Add transaction",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
