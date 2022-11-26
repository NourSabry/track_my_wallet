// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? title;
  final double? spendingAmount;
  final double? spendingPctOfTotal;
  const ChartBar(this.title, this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text('\$${spendingAmount!.toStringAsFixed(0)}'),
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  //we didn;t use the   Colors.grey cause it'd make the color darker, we nneded a customized lighter one
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 4,
        ),
        Text(title!),
      ],
    );
  }
}
