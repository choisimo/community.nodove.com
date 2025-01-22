import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String name = "이름 없음";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        body: const Center(
          child: Text('this is home screen not implemented yet'),
        ),
      ),
    );
  }
}
