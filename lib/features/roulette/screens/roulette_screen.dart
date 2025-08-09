import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/services/app_state.dart';
import '../../roulette/widgets/kawaii_card.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  // ご飯メニュー候補
  final List<String> menus = [
    'カレーライス',
    'ハンバーグ',
    'オムライス',
    'ラーメン',
    '寿司',
    '唐揚げ',
    'パスタ',
    'うどん',
    'サラダ',
    '焼き魚',
  ];

  String? selectedMenu;
  bool isSpinning = false;

  void spinRoulette() async {
    setState(() {
      isSpinning = true;
    });
    // ルーレット風の演出（0.8秒間ランダムに変化）
    for (int i = 0; i < 8; i++) {
      setState(() {
        selectedMenu = menus[Random().nextInt(menus.length)];
      });
      await Future.delayed(const Duration(milliseconds: 100));
    }
    setState(() {
      isSpinning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('今日のご飯ルーレット'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.sunsetGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 280,
                    child: KawaiiCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.restaurant_menu,
                            color: AppColors.primary,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            selectedMenu ?? '今日のご飯は？',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.kawaiiLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (selectedMenu != null && !isSpinning)
                            Text(
                              'このメニューで決まり！',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body,
                            ),
                          if (isSpinning)
                            Text(
                              'ルーレット中...',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.caption,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: isSpinning ? null : spinRoulette,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      isSpinning ? 'ルーレット中...' : 'ルーレットを回す',
                      style: AppTextStyles.button,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // メニュー一覧をかわいく表示
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    children: menus
                        .map((menu) => Chip(
                              label: Text(menu, style: AppTextStyles.bodySmall),
                              backgroundColor: AppColors.pastelOrange,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
