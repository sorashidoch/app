import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/services/app_state.dart';
import '../widgets/kawaii_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: AppColors.rainbowGradient,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // アプリ情報カード
                    KawaiiCard(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: AppColors.primary,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'きょうごはん',
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'バージョン 1.0.0',
                            style: AppTextStyles.caption,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'かわいい系のシンプルなモバイルアプリ',
                            style: AppTextStyles.body,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // テーマ設定
                    KawaiiCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'テーマ設定',
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildThemeOption(
                            context,
                            'ライトテーマ',
                            Icons.wb_sunny,
                            ThemeMode.light,
                            appState.themeMode == ThemeMode.light,
                            () => appState.changeTheme(ThemeMode.light),
                          ),
                          _buildThemeOption(
                            context,
                            'ダークテーマ',
                            Icons.nightlight_round,
                            ThemeMode.dark,
                            appState.themeMode == ThemeMode.dark,
                            () => appState.changeTheme(ThemeMode.dark),
                          ),
                          _buildThemeOption(
                            context,
                            'システム設定に従う',
                            Icons.settings_system_daydream,
                            ThemeMode.system,
                            appState.themeMode == ThemeMode.system,
                            () => appState.changeTheme(ThemeMode.system),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 通知設定
                    KawaiiCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '通知設定',
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('プッシュ通知'),
                            subtitle: const Text('アプリからの通知を受け取る'),
                            value: appState.notificationsEnabled,
                            onChanged: (value) {
                              appState.setNotificationsEnabled(value);
                            },
                            activeColor: AppColors.primary,
                          ),
                          SwitchListTile(
                            title: const Text('サウンド'),
                            subtitle: const Text('通知音を再生する'),
                            value: appState.soundEnabled,
                            onChanged: (value) {
                              appState.setSoundEnabled(value);
                            },
                            activeColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // その他の設定
                    KawaiiCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'その他',
                            style: AppTextStyles.heading3.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSettingItem(
                            context,
                            'プライバシーポリシー',
                            Icons.privacy_tip,
                            () {
                              // TODO: プライバシーポリシー画面を実装
                            },
                          ),
                          _buildSettingItem(
                            context,
                            '利用規約',
                            Icons.description,
                            () {
                              // TODO: 利用規約画面を実装
                            },
                          ),
                          _buildSettingItem(
                            context,
                            'お問い合わせ',
                            Icons.email,
                            () {
                              // TODO: お問い合わせ画面を実装
                            },
                          ),
                          _buildSettingItem(
                            context,
                            '設定をリセット',
                            Icons.refresh,
                            () {
                              _showResetDialog(context, appState);
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

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    IconData icon,
    ThemeMode themeMode,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.2)
              : AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(
              Icons.check_circle,
              color: AppColors.primary,
            )
          : null,
      onTap: onTap,
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

  void _showResetDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('設定をリセット'),
        content: const Text('すべての設定を初期値に戻しますか？\nこの操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              appState.resetSettings();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('設定をリセットしました'),
                  backgroundColor: AppColors.pastelOrange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('リセット'),
          ),
        ],
      ),
    );
  }
}
