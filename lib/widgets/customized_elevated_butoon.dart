// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomizedElevatedButton extends StatelessWidget {
  const CustomizedElevatedButton({this.onPressed, this.title});
  final Function()? onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        title!,
      ),
    );
  }
}
