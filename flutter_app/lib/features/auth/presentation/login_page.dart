import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_chat_client/features/auth/data/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: 실제 로그인 로직 구현
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('로그인 기능이 준비중입니다!')),
                );
                // 임시로 메인 페이지로 이동
                context.go('/');
              },
              child: const Text('로그인'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.go('/user/join');
              },
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}