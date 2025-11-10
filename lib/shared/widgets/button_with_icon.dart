import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';

/// アイコン画像・タイトル・リンクで使えるボタン風カードコンポーネント
/// 既存の `KawaiiCard` 互換のため、`child` を渡した場合はそのまま内容を表示します。
class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
    this.child, // 互換用: 任意のウィジェットを直接表示
    this.link, // ルーティング先（GoRouterのパス）
    this.iconAsset, // 画像アセットパス
    this.iconData, // フォールバック用のMaterialアイコン
    this.title, // タイトル文字列
    this.padding,
    this.backgroundColor,
    this.width,
    this.height,
  });

  // --- 互換・拡張プロパティ ---
  final Widget? child;
  final String? link;
  final String? iconAsset;
  final IconData? iconData;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  void _handleTap(BuildContext context) {
    // 指定があればリンク遷移
    if (link != null && link!.isNotEmpty) {
      context.go(link!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasTap = link != null && link!.isNotEmpty;

    final Widget content = child ?? _buildDefaultContent();

    final Widget container = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: content,
    );

    if (!hasTap) {
      return container;
    }

    return InkWell(
      onTap: () => _handleTap(context),
      borderRadius: BorderRadius.circular(20),
      child: container,
    );
  }

  /// デフォルトのボタン表示（アイコン＋タイトル）
  Widget _buildDefaultContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: iconAsset != null
              ? Image.asset(
                  iconAsset!,
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                )
              : Icon(
                  iconData ?? Icons.circle,
                  color: AppColors.primary,
                  size: 32,
                ),
        ),
        const SizedBox(height: 12),
        if (title != null)
          Text(
            title!,
            style: AppTextStyles.button.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
