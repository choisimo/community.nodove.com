import 'package:flutter/material.dart';

class VerticalPostList extends StatelessWidget {
  final List<Map<String, dynamic>> posts;

  const VerticalPostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: posts.map((post) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: ListTile(
            title: Text(post['title'] ?? ''),
            subtitle: Text('게시물 ID: ${post['id']}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: 게시물 상세 페이지로 이동
            },
          ),
        );
      }).toList(),
    );
  }
}