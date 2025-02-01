import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  final GoException? errorState;

  const ErrorPage(
      {super.key, required this.errorMessage, required this.errorState});

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
