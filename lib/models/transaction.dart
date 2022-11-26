import 'package:flutter/foundation.dart';

class Transaction {
  final double? amount;
  final DateTime? date;
  final String? title;
  final String? id;

  Transaction(
      {@required this.amount,
      required this.id,
      required this.date,
      required this.title});
}
