import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_client/features/home/presentation/widgets/index.dart';
import 'package:flutter_chat_client/features/auth/presentation/join_page.dart';
import 'package:flutter_chat_client/features/auth/presentation/login_page.dart';
import 'package:flutter_chat_client/features/auth/presentation/profile_page.dart';
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
          builder: (context, state) => IndexPage(),
        ),
        GoRoute(
          name: 'post_detail',
          path: '/post/:id',
          builder: (context, state) {
            final postId = int.tryParse(state.pathParameters['id'] ?? '');
            if (postId == null || postId < 1) {
              return ErrorPage(
                  errorMessage: 'Invalid post ID', errorState: state.error);
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
        if (state.error != null) {
          return MaterialPage(
              child: ErrorPage(
                  errorMessage: 'Page not found', errorState: state.error));
        } else {
          return MaterialPage(
              child: const ErrorPage(
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
