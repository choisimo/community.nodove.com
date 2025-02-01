import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  final StateError error;
  const ErrorPage({super.key, required this.errorMessage, required error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
