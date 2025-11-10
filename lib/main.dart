import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as gma;
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'shared/services/app_state.dart';

void main() {
  // 広告SDKなどの初期化に備えてFlutterバインディングを有効化
  WidgetsFlutterBinding.ensureInitialized();

  // Google Mobile Adsを初期化（バナー広告等の利用準備）
  // デスクトップ/WEBでは未対応のためモバイルのみ初期化
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS)) {
    gma.MobileAds.instance.initialize();
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const SumahonoMobileApp(),
    ),
  );
}
