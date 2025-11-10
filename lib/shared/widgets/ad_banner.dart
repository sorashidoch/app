import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../app/theme/colors.dart';

/// 画面下部に表示する共通バナー広告ウィジェット
/// テスト広告IDを使用します。実アプリでは各プラットフォームの本番IDに差し替えてください。
class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  // プラットフォーム毎のテスト用バナー広告ユニットID
  // Android: ca-app-pub-3940256099942544/6300978111
  // iOS:     ca-app-pub-3940256099942544/2934735716
  String get _testUnitId {
    if (kIsWeb) return '';
    // Web以外はパッケージのユーティリティで判定
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'ca-app-pub-3940256099942544/6300978111';
      case TargetPlatform.iOS:
        return 'ca-app-pub-3940256099942544/2934735716';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
    final unitId = _testUnitId;
    if (unitId.isEmpty) return;

    final banner = BannerAd(
      size: AdSize.banner,
      adUnitId: unitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) return;
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // エラー時もリソースを解放
          ad.dispose();
          if (kDebugMode) {
            debugPrint('BannerAd failedToLoad: $error');
          }
        },
      ),
    );

    banner.load();
    _bannerAd = banner;
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 読み込み完了までは高さを確保してプレースホルダを表示
    if (!_isLoaded || _bannerAd == null) {
      // 読み込み前も背景色を表示してエリアを明示する
      return Container(
        height: 50,
        width: double.infinity,
        color: AppColors.backgroundBanner,
        child: const Center(child: SizedBox.shrink()),
      );
    }

    // 読み込み後は広告を背景色付きコンテナでラップ
    return Container(
      color: AppColors.backgroundBanner,
      alignment: Alignment.center,
      child: SizedBox(
        height: _bannerAd!.size.height.toDouble(),
        width: _bannerAd!.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }
}
