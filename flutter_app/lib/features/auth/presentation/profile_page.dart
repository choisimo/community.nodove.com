import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers/auth_providers.dart';
import '../domain/dto/auth_status.dart';
import '../domain/models/user.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    // 인증되지 않은 사용자는 로그인 페이지로 리다이렉트
    if (authState is! AuthAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/user/login');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        elevation: 3,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  _showSettings(context);
                  break;
                case 'logout':
                  _showLogoutDialog(context, ref);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('설정'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('로그아웃'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 프로필 헤더
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[100],
                    child: Text(
                      user.userNick[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.userNick,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getRoleColor(user.userRole),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getRoleText(user.userRole),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 계정 정보
            _buildInfoSection(
              title: '계정 정보',
              children: [
                _buildInfoItem(
                  icon: Icons.person,
                  title: '사용자 ID',
                  subtitle: user.userId,
                ),
                _buildInfoItem(
                  icon: Icons.email,
                  title: '이메일',
                  subtitle: user.email,
                ),
                _buildInfoItem(
                  icon: Icons.badge,
                  title: '닉네임',
                  subtitle: user.userNick,
                ),
                if (user.username != null)
                  _buildInfoItem(
                    icon: Icons.account_circle,
                    title: '이름',
                    subtitle: user.username!,
                  ),
                _buildInfoItem(
                  icon: Icons.calendar_today,
                  title: '가입일',
                  subtitle: _formatDate(user.createdAt),
                ),
                _buildInfoItem(
                  icon: Icons.verified_user,
                  title: '계정 상태',
                  subtitle: user.isActive ? '활성' : '비활성',
                  subtitleColor: user.isActive ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 활동 정보 (추후 구현)
            _buildInfoSection(
              title: '활동 정보',
              children: [
                _buildInfoItem(
                  icon: Icons.article,
                  title: '작성한 게시물',
                  subtitle: '0개',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('내 게시물 기능이 준비중입니다')),
                    );
                  },
                ),
                _buildInfoItem(
                  icon: Icons.favorite,
                  title: '좋아요한 게시물',
                  subtitle: '0개',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('좋아요 목록 기능이 준비중입니다')),
                    );
                  },
                ),
                _buildInfoItem(
                  icon: Icons.bookmark,
                  title: '북마크',
                  subtitle: '0개',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('북마크 기능이 준비중입니다')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 설정
            _buildInfoSection(
              title: '설정',
              children: [
                _buildInfoItem(
                  icon: Icons.edit,
                  title: '프로필 수정',
                  subtitle: '닉네임, 프로필 사진 등',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('프로필 수정 기능이 준비중입니다')),
                    );
                  },
                ),
                _buildInfoItem(
                  icon: Icons.notifications,
                  title: '알림 설정',
                  subtitle: '알림 수신 설정',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('알림 설정 기능이 준비중입니다')),
                    );
                  },
                ),
                _buildInfoItem(
                  icon: Icons.security,
                  title: '보안',
                  subtitle: '비밀번호 변경',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('보안 설정 기능이 준비중입니다')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 로그아웃 버튼
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context, ref),
                icon: const Icon(Icons.logout),
                label: const Text('로그아웃'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Color? subtitleColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: subtitleColor ?? Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Colors.red;
      case UserRole.moderator:
        return Colors.orange;
      case UserRole.user:
        return Colors.blue;
    }
  }

  String _getRoleText(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return '관리자';
      case UserRole.moderator:
        return '운영자';
      case UserRole.user:
        return '일반 사용자';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

  void _showSettings(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('설정 기능이 준비중입니다')),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authNotifierProvider.notifier).logout();
              context.go('/');
            },
            child: const Text(
              '로그아웃',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
