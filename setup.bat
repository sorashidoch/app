@echo off
chcp 65001 >nul

echo 🎀 すまほのもばいるアプリの環境構築を開始します...

REM Flutterがインストールされているかチェック
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Flutterがインストールされていません。
    echo Flutterをインストールしてください: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

echo ✅ Flutterがインストールされています

REM Flutterのバージョンチェック
flutter --version

REM プロジェクトディレクトリ構造を作成
echo 📁 プロジェクトディレクトリ構造を作成中...

REM libディレクトリ構造
mkdir lib\app\theme 2>nul
mkdir lib\features\home\screens 2>nul
mkdir lib\features\home\widgets 2>nul
mkdir lib\features\home\controllers 2>nul
mkdir lib\features\profile\screens 2>nul
mkdir lib\features\profile\widgets 2>nul
mkdir lib\features\profile\controllers 2>nul
mkdir lib\features\settings\screens 2>nul
mkdir lib\features\settings\widgets 2>nul
mkdir lib\features\settings\controllers 2>nul
mkdir lib\shared\widgets 2>nul
mkdir lib\shared\models 2>nul
mkdir lib\shared\services 2>nul
mkdir lib\shared\utils 2>nul

REM assetsディレクトリ構造
mkdir assets\images 2>nul
mkdir assets\animations 2>nul
mkdir assets\icons 2>nul
mkdir assets\fonts 2>nul

echo ✅ ディレクトリ構造を作成しました

REM 依存関係をインストール
echo 📦 依存関係をインストール中...
flutter pub get

echo ✅ 依存関係をインストールしました

REM 開発用の設定ファイルを作成
echo ⚙️ 開発用設定ファイルを作成中...

REM .gitignoreファイルを作成
echo # Flutter/Dart specific > .gitignore
echo .dart_tool/ >> .gitignore
echo .flutter-plugins >> .gitignore
echo .flutter-plugins-dependencies >> .gitignore
echo .packages >> .gitignore
echo .pub-cache/ >> .gitignore
echo .pub/ >> .gitignore
echo build/ >> .gitignore
echo *.lock >> .gitignore
echo. >> .gitignore
echo # Android specific >> .gitignore
echo **/android/**/gradle-wrapper.jar >> .gitignore
echo **/android/.gradle >> .gitignore
echo **/android/captures/ >> .gitignore
echo **/android/gradlew >> .gitignore
echo **/android/gradlew.bat >> .gitignore
echo **/android/local.properties >> .gitignore
echo **/android/**/GeneratedPluginRegistrant.java >> .gitignore
echo. >> .gitignore
echo # iOS specific >> .gitignore
echo **/ios/**/*.mode1v3 >> .gitignore
echo **/ios/**/*.mode2v3 >> .gitignore
echo **/ios/**/*.moved-aside >> .gitignore
echo **/ios/**/*.pbxuser >> .gitignore
echo **/ios/**/*.perspectivev3 >> .gitignore
echo **/ios/**/*sync/ >> .gitignore
echo **/ios/**/.sconsign.dblite >> .gitignore
echo **/ios/**/.tags* >> .gitignore
echo **/ios/**/.vagrant/ >> .gitignore
echo **/ios/**/DerivedData/ >> .gitignore
echo **/ios/**/Icon? >> .gitignore
echo **/ios/**/Pods/ >> .gitignore
echo **/ios/**/.symlinks/ >> .gitignore
echo **/ios/**/profile >> .gitignore
echo **/ios/**/xcuserdata >> .gitignore
echo **/ios/.generated/ >> .gitignore
echo **/ios/Flutter/App.framework >> .gitignore
echo **/ios/Flutter/Flutter.framework >> .gitignore
echo **/ios/Flutter/Flutter.podspec >> .gitignore
echo **/ios/Flutter/Generated.xcconfig >> .gitignore
echo **/ios/Flutter/app.flx >> .gitignore
echo **/ios/Flutter/app.zip >> .gitignore
echo **/ios/Flutter/flutter_assets/ >> .gitignore
echo **/ios/Flutter/flutter_export_environment.sh >> .gitignore
echo **/ios/ServiceDefinitions.json >> .gitignore
echo **/ios/Runner/GeneratedPluginRegistrant.* >> .gitignore
echo. >> .gitignore
echo # IDE specific >> .gitignore
echo .vscode/ >> .gitignore
echo .idea/ >> .gitignore
echo *.iml >> .gitignore
echo *.ipr >> .gitignore
echo *.iws >> .gitignore
echo. >> .gitignore
echo # OS specific >> .gitignore
echo .DS_Store >> .gitignore
echo .DS_Store? >> .gitignore
echo ._* >> .gitignore
echo .Spotlight-V100 >> .gitignore
echo .Trashes >> .gitignore
echo ehthumbs.db >> .gitignore
echo Thumbs.db >> .gitignore
echo. >> .gitignore
echo # Logs >> .gitignore
echo *.log >> .gitignore

echo ✅ .gitignoreファイルを作成しました

echo 🎉 環境構築が完了しました！
echo.
echo 次のコマンドでアプリを実行できます：
echo flutter run
echo.
echo 開発を開始する準備が整いました！✨
pause 