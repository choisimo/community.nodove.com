import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalCategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  const HorizontalCategoryList({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => context.go('/category/${category['id']}'),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue.shade100,
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  category['name'],
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
