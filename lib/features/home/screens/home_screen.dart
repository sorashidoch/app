import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/kawaii_card.dart';
import '../widgets/feature_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                  'ようこそ！',
                                  style: AppTextStyles.heading2.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'きょうのごはんをきめましょう ✨',
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // 機能ボタン
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            children: [
                              FeatureButton(
                                icon: Icons.person,
                                title: 'ごはんルーレット',
                                color: AppColors.pastelPink,
                                onTap: () => context.go('/profile'),
                              ),
                              FeatureButton(
                                icon: Icons.favorite_border,
                                title: 'お気に入り',
                                color: AppColors.pastelBlue,
                                onTap: () {
                                  // TODO: お気に入り機能を実装
                                },
                              ),
                              FeatureButton(
                                icon: Icons.note,
                                title: 'メモ帳',
                                color: AppColors.pastelYellow,
                                onTap: () {
                                  // TODO: メモ帳機能を実装
                                },
                              ),
                              FeatureButton(
                                icon: Icons.photo_library,
                                title: 'ギャラリー',
                                color: AppColors.pastelGreen,
                                onTap: () {
                                  // TODO: ギャラリー機能を実装
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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