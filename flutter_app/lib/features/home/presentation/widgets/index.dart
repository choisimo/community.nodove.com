import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/horizontal_category_list.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/horizontal_post_list.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/section_title.dart';
import 'package:flutter_chat_client/artifacts/content/page/main/vertial_category_list.dart';
import 'package:flutter_chat_client/features/ai/presentation/ai_widgets_simple.dart';
import 'package:flutter_chat_client/features/posts/presentation/post_editor_page_simple.dart';
import 'package:go_router/go_router.dart';

class IndexPage extends ConsumerWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Nodove Community',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          // 글쓰기 버튼
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostEditorPageSimple(),
                ),
              );
            },
            tooltip: '글쓰기',
          ),
          // AI 챗봇 버튼 (준비중)
          IconButton(
            icon: const Icon(Icons.smart_toy),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('AI 도우미 기능이 준비중입니다!')),
              );
            },
            tooltip: 'AI 도우미 (준비중)',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI 스마트 검색창
            const SmartSearchWidget(),
            
            // AI 맞춤 추천 섹션
            const AIRecommendationSection(),
            const SizedBox(height: 24),
            
            // 추천 게시물 섹션 (기존)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SectionTitle(title: '추천 게시물'),
            ),
            _buildEnhancedPostList([
              {'id': 1, 'title': 'Flutter 3.16 업데이트 소식', 'content': 'Flutter 3.16에서 새롭게 추가된 기능들을 살펴보겠습니다. Material 3 지원 강화와 성능 개선이 주요 포인트입니다.'},
              {'id': 2, 'title': 'Riverpod 상태 관리 완벽 가이드', 'content': 'Riverpod을 활용한 효율적인 상태 관리 방법을 단계별로 알아보겠습니다. Provider 패턴부터 고급 사용법까지 모두 다룹니다.'},
              {'id': 3, 'title': 'AI와 함께하는 모바일 앱 개발', 'content': '인공지능 기술을 활용하여 더 스마트한 모바일 앱을 개발하는 방법을 소개합니다. 챗봇부터 추천 시스템까지.'},
            ]),
            const SizedBox(height: 24),
            
            // 인기 카테고리 섹션
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SectionTitle(title: '인기 카테고리'),
            ),
            HorizontalCategoryList(categories: [
              {'id': 'tech', 'name': '기술'},
              {'id': 'life', 'name': '라이프'},
              {'id': 'food', 'name': '음식'},
              {'id': 'ai', 'name': 'AI/ML'},
            ]),
            const SizedBox(height: 24),
            
            // 최신 글 섹션
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SectionTitle(title: '최신 글'),
            ),
            _buildEnhancedVerticalPostList([
              {'id': 4, 'title': 'Flutter 위젯 최적화 팁', 'content': '위젯 트리를 효율적으로 구성하여 앱 성능을 향상시키는 방법들을 알아보겠습니다.'},
              {'id': 5, 'title': '개발자를 위한 디자인 시스템', 'content': '일관성 있는 UI/UX를 위한 디자인 시스템 구축 방법과 Flutter에서의 적용 사례를 소개합니다.'},
              {'id': 6, 'title': '모바일 앱 보안 가이드', 'content': '모바일 앱 개발 시 반드시 고려해야 할 보안 요소들과 Flutter에서의 보안 강화 방법을 다룹니다.'},
            ]),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostEditorPageSimple(),
            ),
          );
        },
        tooltip: '글쓰기',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEnhancedPostList(List<Map<String, dynamic>> posts) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 12),
            child: AIPostCard(
              post: post,
              onTap: () {
                // 게시물 상세 페이지로 이동
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEnhancedVerticalPostList(List<Map<String, dynamic>> posts) {
    return Column(
      children: posts.map((post) {
        return AIPostCard(
          post: post,
          onTap: () {
            // 게시물 상세 페이지로 이동
          },
        );
      }).toList(),
    );
  }
}
