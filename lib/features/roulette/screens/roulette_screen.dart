import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/services/app_state.dart';
import '../../../shared/widgets/button_with_icon.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  String? selectedMenu;
  bool isSpinning = false;
  // 連続して同じ結果を表示しない
  bool avoidSameConsecutive = false;

  // 日付時刻の簡易整形（yyyy/MM/dd HH:mm）
  String _formatDateTime(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}/${two(dt.month)}/${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }

  void spinRoulette(List<String> menus) async {
    if (menus.isEmpty) return;
    final String? previousFinal = selectedMenu; // 直前の最終結果を保持
    // 待機後にBuildContextを使わないよう、先に読み出しておく
    final appState = context.read<AppState>();

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

    // 最終結果を決定（必要に応じて直前と異なるまで再抽選）
    String finalPick = menus[Random().nextInt(menus.length)];
    if (avoidSameConsecutive && previousFinal != null && menus.length > 1) {
      int guard = 0;
      while (finalPick == previousFinal && guard < 20) {
        finalPick = menus[Random().nextInt(menus.length)];
        guard++;
      }
    }

    final now = DateTime.now();
    setState(() {
      isSpinning = false;
      selectedMenu = finalPick;
    });
    // 履歴に追加（グローバル状態）
    await appState.addRouletteHistory(finalPick, now);
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final menus = appState.rouletteMenus;
    final history = appState.rouletteHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('今日のご飯ルーレット'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            tooltip: '料理名を変更',
            icon: const Icon(Icons.tune),
            onPressed: () {
              context.go('/profile/food', extra: '/roulette');
            },
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.sunsetGradient,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // オプション：連続同一結果回避
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                            value: avoidSameConsecutive,
                            onChanged: (value) {
                              setState(() {
                                avoidSameConsecutive = value;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text('連続して同じ結果を表示しない'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: SizedBox(
                          width: 280,
                          child: ButtonWithIcon(
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
                                  const Text(
                                    'このメニューで決まり！',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.body,
                                  ),
                                if (isSpinning)
                                  const Text(
                                    'ルーレット中...',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.caption,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: isSpinning || menus.isEmpty
                            ? null
                            : () => spinRoulette(menus),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          isSpinning
                              ? 'ルーレット中...'
                              : (menus.isEmpty ? '料理名を追加してください' : 'ルーレットを回す'),
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
                                  label: Text(menu,
                                      style: AppTextStyles.bodySmall),
                                  backgroundColor: AppColors.pastelOrange,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      // 履歴表示（最新10件、1行表示）
                      if (history.isNotEmpty) ...[
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                '履歴（最新10件）',
                                style: AppTextStyles.heading3,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                await appState.clearRouletteHistory();
                              },
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('履歴をクリア'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: history
                              .take(10)
                              .map(
                                (h) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    '${_formatDateTime(h.dateTime)}  ${h.menu}',
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
