import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/history/screens/history_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/memo/screens/memo_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/roulette/screens/roulette_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../shared/services/app_state.dart';
import 'theme/app_theme.dart';

class SumahonoMobileApp extends StatelessWidget {
  const SumahonoMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return MaterialApp.router(
          title: 'きょうごはん',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.themeMode,
          locale: appState.locale,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  // ルーター設定
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/roulette',
        builder: (context, state) => const RouletteScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/memo',
        builder: (context, state) => const MemoScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      /*要件定義外-profileに統一or似たような独自要素(一部連携必須) */
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
