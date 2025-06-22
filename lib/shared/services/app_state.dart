import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
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
  
  // ゲッター
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isFirstLaunch => _isFirstLaunch;
  String get userName => _userName;
  String get userAvatar => _userAvatar;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  String get selectedTheme => _selectedTheme;
  
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
  
  // 設定をリセット
  void resetSettings() {
    _themeMode = ThemeMode.light;
    _locale = const Locale('ja');
    _notificationsEnabled = true;
    _soundEnabled = true;
    _selectedTheme = 'default';
    notifyListeners();
  }
} 