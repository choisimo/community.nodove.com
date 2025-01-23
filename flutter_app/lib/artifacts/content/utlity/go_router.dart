import 'package:flutter/material.dart';
import 'package:flutter_chat_client/artifacts/content/page/error/error_page.dart';
import 'package:flutter_chat_client/artifacts/content/page/index.dart';
import 'package:flutter_chat_client/artifacts/content/user/join_page.dart';
import 'package:flutter_chat_client/artifacts/content/user/login_page.dart';
import 'package:flutter_chat_client/artifacts/content/page/post/post_detail_page.dart';
import 'package:flutter_chat_client/artifacts/content/user/profile_page.dart';
import 'package:flutter_chat_client/artifacts/content/utlity/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  static GoRouter? _router;

  static GoRouter initializeRouter(WidgetRef ref) {
    if (_router != null) {
      return _router!;
    }

    final isAuth = ref.watch(authProvider);

    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          name: 'index',
          path: '/',
          builder: (context, state) => IndexPage(),
        ),
        GoRoute(
          name: 'post_detail',
          path: '/post/:id',
          builder: (context, state) {
            final postId = int.tryParse(state.pathParameters['id'] ?? '');
            if (postId == null || postId < 1) {
              return ErrorPage(errorMessage: 'Invalid post ID');
            }
            return PostDetailPage(postId: postId);
          },
        ),
        GoRoute(
            path: '/user/login',
            builder: (context, state) {
              return const LoginPage();
            }),
        GoRoute(
            path: '/user/join',
            builder: (context, state) {
              return const JoinPage();
            }),
        GoRoute(
            name: 'profile',
            path: '/user/profile',
            pageBuilder: (context, state) {
              return MaterialPage(child: ProfilePage());
            })
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage(errorMessage: 'Page not found'));
      },
      redirect: (context, state) {
        final location = state.matchedLocation;

        if ((isAuth.token == false) &&
            (location != '/user/login') &&
            (location != '/user/join')) {
          return '/user/login';
        }
        return null;
      },
    );
    return _router!;
  }

  static GoRouter getRouter() => _router!;
}
