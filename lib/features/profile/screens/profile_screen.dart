import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/services/app_state.dart';
import '../widgets/kawaii_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: AppColors.sunsetGradient,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // プロフィールカード
                    KawaiiCard(
                      child: Column(
                        children: [
                          // アバター
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [AppColors.pastelPink, AppColors.pastelBlue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  offset: const Offset(0, 4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // ユーザー名
                          Text(
                            appState.userName.isEmpty ? 'ユーザー名' : appState.userName,
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          // ステータス
                          Text(
                            'かわいいアプリユーザー ✨',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 統計情報
                    KawaiiCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '統計情報',
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('お気に入り', '12', Icons.favorite),
                              _buildStatItem('メモ', '8', Icons.note),
                              _buildStatItem('写真', '24', Icons.photo),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 設定オプション
                    KawaiiCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '設定',
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          _buildSettingItem(
                            context,
                            'ユーザー名を変更',
                            Icons.edit,
                            () {
                              _showNameDialog(context, appState);
                            },
                          ),
                          
                          _buildSettingItem(
                            context,
                            '通知設定',
                            Icons.notifications,
                            () {
                              // TODO: 通知設定画面を実装
                            },
                          ),
                          
                          _buildSettingItem(
                            context,
                            'テーマ設定',
                            Icons.palette,
                            () {
                              // TODO: テーマ設定画面を実装
                            },
                          ),
                          
                          _buildSettingItem(
                            context,
                            'アプリについて',
                            Icons.info,
                            () {
                              // TODO: アプリ情報画面を実装
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.body,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.textSecondary,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  void _showNameDialog(BuildContext context, AppState appState) {
    final TextEditingController controller = TextEditingController(
      text: appState.userName,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ユーザー名を変更'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '新しいユーザー名',
            hintText: 'かわいい名前を入力してください',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              appState.setUserName(controller.text);
              Navigator.pop(context);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
} 