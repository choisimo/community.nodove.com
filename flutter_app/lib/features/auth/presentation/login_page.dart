import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authProvider 상태 변화 감지해서 처리하기

    ref.listen(authProvider, (prevoius, next) {
      if (next.token == true) {
        log('navigate to index');
        context.go('/');
      } else if (next.errorMessage != null) {
        log('Login failed');
      }
    });

    final loginState = ref.watch(authProvider);
    final loginNotifier = ref.read(authProvider.notifier);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (loginState.isLoading)
              const CircularProgressIndicator()
            else ...[
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  await loginNotifier.login(email, password, ref);
                },
                child: Text('로그인'),
              ),
              if (loginState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    loginState.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
