import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalPostList extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  const HorizontalPostList({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final post = posts[index];
          return GestureDetector(
            onTap: () => context.go('/post/${post['id']}'),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  post['title'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
