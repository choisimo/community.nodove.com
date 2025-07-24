import 'package:flutter/material.dart';

class HorizontalCategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const HorizontalCategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Chip(
              label: Text(category['name'] ?? ''),
              onDeleted: () {
                // TODO: 카테고리 필터링 로직
              },
              deleteIcon: const Icon(Icons.filter_list, size: 16),
            ),
          );
        },
      ),
    );
  }
}