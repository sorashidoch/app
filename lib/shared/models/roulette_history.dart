import 'package:flutter/material.dart';

/// ルーレット履歴アイテム（メニュー名 + 日時）
@immutable
class RouletteHistoryItem {
  const RouletteHistoryItem({required this.menu, required this.dateTime});
  final String menu;
  final DateTime dateTime;

  // シリアライズ（簡易：menu|iso8601）
  String toPersistedString() => '$menu|${dateTime.toIso8601String()}';

  static RouletteHistoryItem? fromPersistedString(String value) {
    final sep = value.indexOf('|');
    if (sep <= 0) return null;
    final m = value.substring(0, sep);
    final dtStr = value.substring(sep + 1);
    final dt = DateTime.tryParse(dtStr);
    if (dt == null) return null;
    return RouletteHistoryItem(menu: m, dateTime: dt);
  }
}
