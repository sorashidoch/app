import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/feature_button.dart';
import '../widgets/kawaii_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ヘッダー部分
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // アプリタイトル
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF6B9D),
                            Color(0xFFFF8E53),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'きょうごはん',
                            style: AppTextStyles.kawaiiLarge.copyWith(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '今日のご飯に迷った時のお手伝い',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 設定ボタン
                    IconButton(
                      onPressed: () => context.go('/settings'),
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              // メインコンテンツ
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // ウェルカムカード
                          KawaiiCard(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    'きょうのごはんをきめましょう✨',
                                    style: AppTextStyles.body.copyWith(
                                      fontSize: 14,
                                      height: 1.2,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 機能ボタン
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            children: [
                              FeatureButton(
                                icon: Icons.gps_fixed,
                                title: 'ルーレット',
                                color: AppColors.pastelPink,
                                onTap: () =>
                                    context.go('/roulette'), // ルーレット画面へ遷移（仮）
                              ),
                              FeatureButton(
                                icon: Icons.person, // プロフィールアイコン
                                title: 'プロフィール', // プロフィール
                                color: AppColors.pastelOrange, // オレンジ色に変更
                                onTap: () =>
                                    context.go('/profile'), // ルーレット画面へ遷移
                              ),
                              FeatureButton(
                                icon: Icons.note,
                                title: 'メモ帳',
                                color: AppColors.pastelOrange,
                                onTap: () => context.go('/memo'),
                              ),
                              FeatureButton(
                                icon: Icons.history,
                                title: '履歴・お気に入り',
                                color: AppColors.pastelPurple,
                                onTap: () => context.go('/history'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
