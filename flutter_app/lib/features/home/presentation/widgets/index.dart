import 'package:flutter/material.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/horizontal_category_list.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/horizontal_post_list.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/section_title.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/vertial_category_list.dart';
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
          '메인 페이지',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 검색창
            TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              onSubmitted: (query) {
                // 검색 처리 로직
                context.go('/search?query=$query');
              },
            ),
            const SizedBox(height: 24),
            // 추천 게시물 섹션
            const SectionTitle(title: '추천 게시물'),
            HorizontalPostList(posts: [
              {'id': 1, 'title': '첫 번째 게시물'},
              {'id': 2, 'title': '두 번째 게시물'},
              {'id': 3, 'title': '세 번째 게시물'},
            ]),
            const SizedBox(height: 24),
            // 인기 카테고리 섹션
            const SectionTitle(title: '인기 카테고리'),
            HorizontalCategoryList(categories: [
              {'id': 'tech', 'name': '기술'},
              {'id': 'life', 'name': '라이프'},
              {'id': 'food', 'name': '음식'},
            ]),
            const SizedBox(height: 24),
            // 최신 글 섹션
            const SectionTitle(title: '최신 글'),
            VerticalPostList(posts: [
              {'id': 4, 'title': '네 번째 게시물'},
              {'id': 5, 'title': '다섯 번째 게시물'},
              {'id': 6, 'title': '여섯 번째 게시물'},
            ]),
          ],
        ),
      ),
    );
  }
}
