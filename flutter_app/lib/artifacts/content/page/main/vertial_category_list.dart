import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerticalPostList extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  const VerticalPostList({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: posts.map((post) {
        return GestureDetector(
          onTap: () => context.go('/post/${post['id']}'),
          child: Card(
            child: ListTile(
              title: Text(post['title']),
              trailing: const Icon(Icons.arrow_forward),
            ),
          ),
        );
      }).toList(),
    );
  }
}
