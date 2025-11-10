#!/bin/bash

# すまほのもばいるアプリ 環境構築スクリプト

echo "🎀 すまほのもばいるアプリの環境構築を開始します..."

# Flutterがインストールされているかチェック
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutterがインストールされていません。"
    echo "Flutterをインストールしてください: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutterがインストールされています"

# Flutterのバージョンチェック
flutter --version

# プロジェクトディレクトリ構造を作成
echo "📁 プロジェクトディレクトリ構造を作成中..."

# libディレクトリ構造
mkdir -p lib/app/theme
mkdir -p lib/features/home/screens
mkdir -p lib/features/home/widgets
mkdir -p lib/features/home/controllers
mkdir -p lib/features/profile/screens
mkdir -p lib/features/profile/widgets
mkdir -p lib/features/profile/controllers
mkdir -p lib/features/settings/screens
mkdir -p lib/features/settings/widgets
mkdir -p lib/features/settings/controllers
mkdir -p lib/shared/widgets
mkdir -p lib/shared/models
mkdir -p lib/shared/services
mkdir -p lib/shared/utils

# assetsディレクトリ構造
mkdir -p assets/images
mkdir -p assets/animations
mkdir -p assets/icons
mkdir -p assets/fonts

echo "✅ ディレクトリ構造を作成しました"

# 依存関係をインストール
echo "📦 依存関係をインストール中..."
flutter pub get

echo "✅ 依存関係をインストールしました"

# 開発用の設定ファイルを作成
echo "⚙️ 開発用設定ファイルを作成中..."

# .gitignoreファイルを作成
cat > .gitignore << 'EOF'
# Flutter/Dart specific
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
*.lock

# Android specific
**/android/**/gradle-wrapper.jar
**/android/.gradle
**/android/captures/
**/android/gradlew
**/android/gradlew.bat
**/android/local.properties
**/android/**/GeneratedPluginRegistrant.java

# iOS specific
**/ios/**/*.mode1v3
**/ios/**/*.mode2v3
**/ios/**/*.moved-aside
**/ios/**/*.pbxuser
**/ios/**/*.perspectivev3
**/ios/**/*sync/
**/ios/**/.sconsign.dblite
**/ios/**/.tags*
**/ios/**/.vagrant/
**/ios/**/DerivedData/
**/ios/**/Icon?
**/ios/**/Pods/
**/ios/**/.symlinks/
**/ios/**/profile
**/ios/**/xcuserdata
**/ios/.generated/
**/ios/Flutter/App.framework
**/ios/Flutter/Flutter.framework
**/ios/Flutter/Flutter.podspec
**/ios/Flutter/Generated.xcconfig
**/ios/Flutter/app.flx
**/ios/Flutter/app.zip
**/ios/Flutter/flutter_assets/
**/ios/Flutter/flutter_export_environment.sh
**/ios/ServiceDefinitions.json
**/ios/Runner/GeneratedPluginRegistrant.*

# IDE specific
.vscode/
.idea/
*.iml
*.ipr
*.iws

# OS specific
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Logs
*.log
EOF

echo "✅ .gitignoreファイルを作成しました"

# READMEファイルを更新
cat > README.md << 'EOF'
# すまほのもばいるアプリ

かわいい系のシンプルなモバイルアプリです。

## 開発環境

- Flutter: 3.16.0以上
- Dart: 3.2.0以上

## セットアップ

1. Flutterをインストール
2. 依存関係をインストール:
   ```bash
   flutter pub get
   ```
3. アプリを実行:
   ```bash
   flutter run
   ```

## プロジェクト構造

```
lib/
├── main.dart                 # アプリのエントリーポイント
├── app/                      # アプリ設定
│   ├── app.dart             # アプリのルートウィジェット
│   └── theme/               # テーマ設定
├── features/                # 機能別モジュール
│   ├── home/               # ホーム機能
│   ├── profile/            # プロフィール機能
│   └── settings/           # 設定機能
├── shared/                 # 共通コンポーネント
│   ├── widgets/            # 共通ウィジェット
│   ├── models/             # データモデル
│   ├── services/           # ビジネスロジック
│   └── utils/              # ユーティリティ
└── assets/                 # アセットファイル
    ├── images/             # 画像ファイル
    ├── animations/         # Lottieアニメーション
    ├── fonts/              # カスタムフォント
    └── icons/              # カスタムアイコン
```

## 開発ルール

- すべてのコードコメントは日本語で記述
- 変数名や関数名は英語を使用
- かわいい系のデザインを心がける
EOF

echo "✅ READMEファイルを更新しました"

echo "🎉 環境構築が完了しました！"
echo ""
echo "次のコマンドでアプリを実行できます："
echo "flutter run"
echo ""
echo "開発を開始する準備が整いました！✨" 