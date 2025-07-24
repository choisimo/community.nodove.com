import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_client/features/home/presentation/widgets/index.dart';
import 'package:flutter_chat_client/features/auth/presentation/join_page.dart';
import 'package:flutter_chat_client/features/auth/presentation/login_page.dart';
import 'package:flutter_chat_client/features/auth/presentation/profile_page.dart';
import 'package:flutter_chat_client/features/auth/data/providers/auth_providers.dart';
import 'package:flutter_chat_client/features/posts/presentation/post_editor_page_simple.dart';
import 'package:flutter_chat_client/features/posts/presentation/post_detail_page.dart';
import 'package:flutter_chat_client/shared/presentation/error/error_page.dart';
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
          builder: (context, state) => const IndexPage(),
        ),
        GoRoute(
          name: 'post_editor',
          path: '/post/create',
          builder: (context, state) => const PostEditorPageSimple(),
        ),
        GoRoute(
          name: 'post_edit',
          path: '/post/edit/:id',
          builder: (context, state) {
            final postId = int.tryParse(state.pathParameters['id'] ?? '');
            if (postId == null || postId < 1) {
              return const ErrorPage(
                errorMessage: 'Invalid post ID',
                errorState: null,
              );
            }
            return PostEditorPageSimple(postId: postId);
          },
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
              return const MaterialPage(child: ProfilePage());
            }),
      ],
      errorPageBuilder: (context, state) {
        if (state.error != null) {
          return const MaterialPage(
              child: ErrorPage(
                  errorMessage: 'Page not found', errorState: null));
        } else {
          return const MaterialPage(
              child: ErrorPage(
                  errorMessage: 'Page not found', errorState: null));
        }
      },
      redirect: (context, state) {
        final location = state.matchedLocation;

        if ((ref.read(authProvider).token == false) &&
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
