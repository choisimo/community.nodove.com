import 'dart:ffi';

import 'package:flutter/material.dart';

class PostListPage extends StatelessWidget {
  final Long pageNum;
  const PostListPage({super.key, required this.pageNum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List Page : $pageNum'),
      ),
    );
  }
}
