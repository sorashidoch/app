# Flutter すまほのもばいるアプリ 技術仕様書

## 1. 技術スタック

### フレームワーク・言語

- **Flutter**: 3.16.0以上
- **Dart**: 3.2.0以上
- **開発環境**: Android Studio / VS Code

### 主要パッケージ

```yaml
dependencies:
  flutter:
    sdk: flutter
  # 状態管理
  provider: ^6.1.1

  # ナビゲーション
  go_router: ^12.1.3

  # ローカルストレージ
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0

  # UI・アニメーション
  flutter_animate: ^4.2.0
  lottie: ^2.7.0

  # かわいい系アイコン・フォント
  google_fonts: ^6.1.0

  # 画像処理
  image_picker: ^1.0.4
  cached_network_image: ^3.3.0

  # 通知
  flutter_local_notifications: ^16.3.0

  # 設定管理
  settings_ui: ^2.0.2
```

## 2. プロジェクト構造

```
lib/
├── main.dart                 # アプリのエントリーポイント
├── app/
│   ├── app.dart             # アプリのルートウィジェット
│   └── theme/
│       ├── app_theme.dart   # テーマ設定
│       ├── colors.dart      # カラーパレット
│       └── text_styles.dart # テキストスタイル
├── features/
│   ├── home/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── controllers/
│   ├── profile/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── controllers/
│   └── settings/
│       ├── screens/
│       ├── widgets/
│       └── controllers/
├── shared/
│   ├── widgets/             # 共通ウィジェット
│   ├── models/              # データモデル
│   ├── services/            # ビジネスロジック
│   └── utils/               # ユーティリティ
└── assets/
    ├── images/              # 画像ファイル
    ├── animations/          # Lottieアニメーション
    ├── fonts/               # カスタムフォント
    └── icons/               # カスタムアイコン
```

## 3. デザインシステム

### カラーパレット（かわいい系）

```dart
class AppColors {
  // メインカラー
  static const Color primary = Color(0xFFFFB6C1);    // ライトピンク
  static const Color secondary = Color(0xFF87CEEB);  // スカイブルー
  static const Color accent = Color(0xFFFFD700);     // ゴールド

  // パステルカラー
  static const Color pastelPink = Color(0xFFFFC0CB);
  static const Color pastelBlue = Color(0xFFADD8E6);
  static const Color pastelYellow = Color(0xFFFFFACD);
  static const Color pastelGreen = Color(0xFF98FB98);
  static const Color pastelPurple = Color(0xFFE6E6FA);

  // 背景色
  static const Color background = Color(0xFFFEFEFE);
  static const Color surface = Color(0xFFFFFFFF);

  // テキスト色
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
}
```

### テキストスタイル

```dart
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
```

## 4. 画面設計

### 主要画面構成

1. **スプラッシュ画面**
   - かわいいロゴアニメーション
   - アプリ名の表示

2. **ホーム画面**
   - メイン機能へのアクセス
   - かわいいカードUI
   - グラデーション背景

3. **プロフィール画面**
   - ユーザー情報表示
   - アバター設定
   - 統計情報

4. **設定画面**
   - テーマ変更
   - 通知設定
   - アプリ情報

## 5. 状態管理

### Provider パターン

```dart
// アプリ全体の状態管理
class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('ja');

  // ゲッター・セッター
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void changeTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
```

## 6. ナビゲーション

### GoRouter によるルーティング

```dart
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
```

## 7. アニメーション・エフェクト

### かわいいアニメーション

- ページ遷移時のフェードイン・アウト
- ボタンタップ時のスケールアニメーション
- カードのホバーエフェクト
- ローディングアニメーション（かわいいキャラクター）

## 8. データ管理

### ローカルストレージ

- SharedPreferences: 設定データ
- SQLite: ユーザーデータ
- ファイルシステム: 画像・メディア

## 9. パフォーマンス最適化

- ウィジェットの適切な分離
- 画像のキャッシュ
- アニメーションの最適化
- メモリリークの防止

## 10. テスト戦略

- ユニットテスト: ビジネスロジック
- ウィジェットテスト: UIコンポーネント
- 統合テスト: 画面遷移・機能連携
