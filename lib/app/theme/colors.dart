import 'package:flutter/material.dart';

class AppColors {
  // メインカラー（くすみオレンジ）
  static const Color primary = Color(0xFFF4A261); // くすみオレンジ
  static const Color secondary = Color(0xFFF4A261); // くすみオレンジ
  static const Color accent = Color(0xFFFFD700); // ゴールド

  // パステルカラー（使用色のみ）
  static const Color pastelPink = Color(0xFFFFB3BA); // ピンク
  static const Color pastelRed = Color(0xFFFF8A80); // 赤
  static const Color pastelOrange = Color(0xFFFFCC80); // オレンジ
  static const Color pastelPurple = Color(0xFFE1BEE7); // 紫

  // 背景色・白
  static const Color background = Color(0xFFFEFEFE); // 白（背景）
  static const Color surface = Color(0xFFFFFFFF);   // 白（サーフェス）

  // テキスト色
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);

  // 状態色（赤・オレンジのみ残す）
  static const Color error = Color(0xFFF44336); // エラー（赤）
  static const Color warning = Color(0xFFFF9800); // 警告（オレンジ）
  static const Color info = Color(0xFFF4A261); // 情報（オレンジ）

  // グラデーション（緑・ミント等を除外）
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [pastelPink, pastelOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient rainbowGradient = LinearGradient(
    colors: [pastelPink, pastelOrange, pastelRed, pastelPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [pastelPink, pastelOrange],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // シャドウ色
  static Color shadowColor = primary.withOpacity(0.1);
  static Color shadowColorDark = primary.withOpacity(0.2);
}
