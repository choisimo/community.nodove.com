import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Index',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/post/1');
          },
          child: Text('Go to Post 1'),
        ),
      ),
    );
  }
}
