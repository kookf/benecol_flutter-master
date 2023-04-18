
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    required this.errorString
  }) : super(key: key);

  final String errorString;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorString,
      style: TextStyle(
        color: Colors.red
      )
    );
  }
}

