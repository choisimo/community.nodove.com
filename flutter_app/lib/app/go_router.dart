import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/widgets/index.dart';
import '../features/auth/presentation/join_page.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/profile_page.dart';
import '../features/auth/data/providers/auth_providers.dart';
import '../features/auth/domain/dto/auth_status.dart';
import '../features/posts/presentation/post_create_page.dart';
import '../features/posts/presentation/post_detail_page.dart';
import '../features/search/presentation/search_page.dart';
import '../shared/presentation/error/error_page.dart';

class MyAppRouter {
  static GoRouter? _router;

  static GoRouter initializeRouter(WidgetRef ref) {
    if (_router != null) {
      return _router!;
    }

    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          name: 'index',
          path: '/',
          builder: (context, state) => const IndexPage(),
        ),
        GoRoute(
          name: 'post_create',
          path: '/post/create',
          builder: (context, state) => const PostCreatePage(),
        ),
        GoRoute(
          name: 'post_detail',
          path: '/post/:id',
          builder: (context, state) {
            final postId = int.tryParse(state.pathParameters['id'] ?? '');
            if (postId == null || postId < 1) {
              return const ErrorPage(
                errorMessage: 'Invalid post ID',
                errorState: null,
              );
            }
            return PostDetailPage(postId: postId);
          },
        ),
        GoRoute(
          name: 'search',
          path: '/search',
          builder: (context, state) {
            final query = state.uri.queryParameters['query'] ?? '';
            return SearchPage(query: query);
          },
        ),
        GoRoute(
          name: 'category',
          path: '/category/:id',
          builder: (context, state) {
            final categoryId = state.pathParameters['id'] ?? '';
            return CategoryPage(categoryId: categoryId);
          },
        ),
        GoRoute(
          path: '/user/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/user/join',
          builder: (context, state) => const JoinPage(),
        ),
        GoRoute(
          name: 'profile',
          path: '/user/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(
          child: ErrorPage(
            errorMessage: 'Page not found',
            errorState: null,
          ),
        );
      },
      redirect: (context, state) {
        final authState = ref.read(authNotifierProvider);
        final location = state.matchedLocation;

        // 인증이 필요한 페이지들
        final protectedRoutes = ['/post/create', '/user/profile'];
        
        // 인증되지 않은 사용자가 보호된 페이지에 접근하려 할 때
        if (authState is! AuthAuthenticated && 
            protectedRoutes.any((route) => location.startsWith(route))) {
          return '/user/login';
        }

        // 이미 인증된 사용자가 로그인/회원가입 페이지에 접근하려 할 때
        if (authState is AuthAuthenticated && 
            (location == '/user/login' || location == '/user/join')) {
          return '/';
        }

        return null;
      },
    );

    // 앱 시작 시 인증 상태 확인
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider.notifier).checkAuthStatus();
    });

    return _router!;
  }

  static GoRouter getRouter() => _router!;
}

// 카테고리 페이지 구현
class CategoryPage extends StatelessWidget {
  final String categoryId;
  
  const CategoryPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('카테고리: $categoryId')),
      body: const Center(
        child: Text('카테고리 페이지가 준비중입니다'),
      ),
    );
  }
}
