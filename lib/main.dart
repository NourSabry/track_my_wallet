// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_element, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:track_my_wallet/screens/home_page.dart';

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
