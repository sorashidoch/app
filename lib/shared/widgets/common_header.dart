import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';

/// 共通ヘッダー（Homeへ戻るボタン + 機能名テキストのみ）
class CommonHeader extends StatelessWidget {
  const CommonHeader({super.key, required this.title});

  /// 機能名（画面タイトル）
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 画面の背景（グラデーションや白）が見えるように、外側は透明の余白にします
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondaryHeader, // 角丸カードの背景色
          borderRadius: BorderRadius.circular(16), // 横長の角丸
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Homeへ戻るボタン
            IconButton(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              color: AppColors.textPrimary,
              iconSize: 24,
              tooltip: 'ホームへ戻る',
            ),
            const SizedBox(width: 8),
            // タイトル
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.kawaiiLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
