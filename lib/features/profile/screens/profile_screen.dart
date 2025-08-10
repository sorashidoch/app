import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/allergen.dart';
import '../../../shared/models/allergen_icons.dart';
import '../../../shared/services/app_state.dart';

/// プロフィール画面：選択中アレルゲン表示 + ルーレット料理名一覧（変更ボタン）
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    // 見出しウィジェット（共通）
    Widget buildSectionHeader(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    // 並び順を日本語ラベルで整える
    final selected = appState.selectedAllergens.toList()..sort(compareByLabel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
      ),
      body: ListView(
        children: [
          // 選択中アレルゲンの表示と遷移ボタン
          buildSectionHeader('選択中のアレルゲン'),
          if (selected.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('未選択です'),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                children: selected
                    .map(
                      (a) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: InputChip(
                          avatar: Icon(
                            iconForAllergen(a),
                            size: 18,
                          ),
                          label: Text(allergenLabel[a] ?? a.name),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.tune),
                label: const Text('変更する（アレルゲン）'),
                onPressed: () {
                  context.go('/profile/allergy');
                },
              ),
            ),
          ),

          // ルーレットの料理名（一覧と変更ボタンのみ）
          buildSectionHeader('ルーレットの料理名'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              children: appState.rouletteMenus
                  .map(
                    (m) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      child: InputChip(
                        label: Text(m),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (appState.rouletteMenus.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('料理名が未登録です'),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.tune),
                label: const Text('変更する（料理名）'),
                onPressed: () {
                  context.go('/profile/food');
                },
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
      // 下部の操作ボタン（ホームへ戻る / 設定完了）
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text('ホームへ'),
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('設定完了'),
                  onPressed: () async {
                    await Navigator.of(context).maybePop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
