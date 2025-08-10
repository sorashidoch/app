import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/allergen.dart';

class AppState extends ChangeNotifier {
  AppState() {
    _initialize();
  }
  // 永続化キー
  static const String _prefsKeySelectedAllergens = 'selected_allergens';
  static const String _prefsKeyRouletteMenus = 'roulette_menus';

  Future<void> _initialize() async {
    await _loadSelectedAllergensFromPrefs();
    await _loadRouletteMenusFromPrefs();
  }

  // テーマモード
  ThemeMode _themeMode = ThemeMode.light;

  // ロケール設定
  Locale _locale = const Locale('ja');

  // ユーザー設定
  bool _isFirstLaunch = true;
  String _userName = '';
  String _userAvatar = '';

  // アプリ設定
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  String _selectedTheme = 'default';

  // アレルゲン選択状態（重複不可のため Set を使用）
  final Set<Allergen> _selectedAllergens = <Allergen>{};

  // ルーレットの料理名一覧（ユーザーが編集可能）
  final List<String> _rouletteMenus = <String>[];

  // ゲッター
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isFirstLaunch => _isFirstLaunch;
  String get userName => _userName;
  String get userAvatar => _userAvatar;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  String get selectedTheme => _selectedTheme;
  Set<Allergen> get selectedAllergens => _selectedAllergens;
  List<String> get rouletteMenus => List.unmodifiable(_rouletteMenus);

  // テーマ変更
  void changeTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  // ロケール変更
  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // 初回起動フラグ設定
  void setFirstLaunch(bool value) {
    _isFirstLaunch = value;
    notifyListeners();
  }

  // ユーザー名設定
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  // アバター設定
  void setUserAvatar(String avatar) {
    _userAvatar = avatar;
    notifyListeners();
  }

  // 通知設定
  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  // サウンド設定
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
    notifyListeners();
  }

  // テーマ設定
  void setSelectedTheme(String theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  // アレルゲンの追加・削除
  Future<void> setAllergenSelected(Allergen allergen, bool isSelected) async {
    if (isSelected) {
      _selectedAllergens.add(allergen);
    } else {
      _selectedAllergens.remove(allergen);
    }
    await _saveSelectedAllergensToPrefs();
    notifyListeners();
  }

  // アレルゲンを全てクリア
  Future<void> clearAllergens() async {
    _selectedAllergens.clear();
    await _saveSelectedAllergensToPrefs();
    notifyListeners();
  }

  // ルーレットの料理名を追加
  Future<void> addRouletteMenu(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    // 重複を避ける（大文字小文字と全角半角を簡易同一視）
    final exists =
        _rouletteMenus.any((m) => m.toLowerCase() == trimmed.toLowerCase());
    if (exists) return;
    _rouletteMenus.add(trimmed);
    await _saveRouletteMenusToPrefs();
    notifyListeners();
  }

  // ルーレットの料理名を削除
  Future<void> removeRouletteMenu(String name) async {
    _rouletteMenus.remove(name);
    await _saveRouletteMenusToPrefs();
    notifyListeners();
  }

  // ルーレットの料理名を全てクリア
  Future<void> clearRouletteMenus() async {
    _rouletteMenus.clear();
    await _saveRouletteMenusToPrefs();
    notifyListeners();
  }

  // 設定をリセット
  void resetSettings() {
    _themeMode = ThemeMode.light;
    _locale = const Locale('ja');
    _notificationsEnabled = true;
    _soundEnabled = true;
    _selectedTheme = 'default';
    _selectedAllergens.clear();
    _rouletteMenus
      ..clear()
      ..addAll(_defaultRouletteMenus);
    notifyListeners();
  }

  // --- 永続化（SharedPreferences） ---
  Future<void> _saveSelectedAllergensToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final names = _selectedAllergens.map((e) => e.name).toList(growable: false);
    await prefs.setStringList(_prefsKeySelectedAllergens, names);
  }

  Future<void> _loadSelectedAllergensFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKeySelectedAllergens) ?? <String>[];
    _selectedAllergens
      ..clear()
      ..addAll(saved.map((name) => Allergen.values.byName(name)));
    notifyListeners();
  }

  Future<void> _saveRouletteMenusToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKeyRouletteMenus, _rouletteMenus);
  }

  Future<void> _loadRouletteMenusFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKeyRouletteMenus);
    _rouletteMenus
      ..clear()
      ..addAll(saved == null || saved.isEmpty ? _defaultRouletteMenus : saved);
    notifyListeners();
  }
}

// デフォルトのルーレット料理名
const List<String> _defaultRouletteMenus = <String>[
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
