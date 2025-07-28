import 'package:flutter/material.dart';

class AppColors {
  // メインカラー（くすみオレンジ）
  static const Color primary = Color(0xFFF4A261);    // くすみオレンジ
  static const Color secondary = Color(0xFFF4A261);  // くすみオレンジ
  static const Color accent = Color(0xFFFFD700);     // ゴールド
  
  // パステルカラー
  static const Color pastelPink = Color(0xFFF4A261);    // くすみオレンジ
  static const Color pastelBlue = Color(0xFFF4A261);    // くすみオレンジ
  static const Color pastelYellow = Color(0xFFFFFACD);
  static const Color pastelGreen = Color(0xFF98FB98);
  static const Color pastelPurple = Color(0xFFE6E6FA);
  static const Color pastelOrange = Color(0xFFF4A261);  // くすみオレンジ
  static const Color pastelMint = Color(0xFF98FF98);
  static const Color pastelLavender = Color(0xFFE6E6FA);
  
  // 背景色
  static const Color background = Color(0xFFFEFEFE);
  static const Color surface = Color(0xFFFFFFFF);
  
  // テキスト色
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  
  // 状態色
  static const Color success = Color(0xFF4CAF50);    // 成功（緑）
  static const Color error = Color(0xFFF44336);      // エラー（赤）
  static const Color warning = Color(0xFFFF9800);    // 警告（オレンジ）
  static const Color info = Color(0xFFF4A261);       // くすみオレンジ
  
  // グラデーション
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [pastelPink, pastelBlue], // どちらもくすみオレンジ
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient rainbowGradient = LinearGradient(
    colors: [pastelPink, pastelYellow, pastelGreen, pastelBlue, pastelPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [pastelPink, pastelOrange, pastelYellow],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // シャドウ色
  static Color shadowColor = primary.withOpacity(0.1);
  static Color shadowColorDark = primary.withOpacity(0.2);
} 