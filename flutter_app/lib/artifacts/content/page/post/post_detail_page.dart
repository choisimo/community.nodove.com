import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post $postId'),
      ),
      body: Center(
        child: Text('Post $postId'),
      ),
    );
  }
}
