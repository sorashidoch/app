import 'package:flutter/material.dart';

/// お気に入りメモアイテム（タイトル・内容・元メモの作成日時）
@immutable
class FavoriteMemoItem {
  const FavoriteMemoItem({
    required this.title,
    required this.content,
    required this.memoDateTime,
  });

  final String title;
  final String content;
  final DateTime memoDateTime;

  /// 簡易シリアライズ: title\u0001content\u0001iso8601
  /// 区切り文字は制御文字(\u0001)を使用して衝突可能性を下げる
  String toPersistedString() =>
      '$title\u0001$content\u0001${memoDateTime.toIso8601String()}';

  static FavoriteMemoItem? fromPersistedString(String value) {
    final parts = value.split('\u0001');
    if (parts.length != 3) return null;
    final dt = DateTime.tryParse(parts[2]);
    if (dt == null) return null;
    return FavoriteMemoItem(
        title: parts[0], content: parts[1], memoDateTime: dt);
  }

  /// 識別のため、タイトル+日時をキーとして扱う（内容は参考情報）
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteMemoItem &&
        other.title == title &&
        other.memoDateTime == memoDateTime;
  }

  @override
  int get hashCode => Object.hash(title, memoDateTime);
}
