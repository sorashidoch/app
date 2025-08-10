import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/allergen.dart';
import '../../../shared/models/allergen_icons.dart';
import '../../../shared/services/app_state.dart';

/// プロフィール画面：アレルゲン登録
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

    // トグルチップ（共通）
    Widget buildAllergenChip(Allergen allergen) {
      final isSelected = appState.selectedAllergens.contains(allergen);
      final theme = Theme.of(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconForAllergen(allergen),
                size: 18,
                color: isSelected ? theme.colorScheme.onPrimaryContainer : null,
              ),
              const SizedBox(width: 8),
              Text(allergenLabel[allergen] ?? allergen.name),
            ],
          ),
          selected: isSelected,
          onSelected: (value) async {
            await appState.setAllergenSelected(allergen, value);
          },
          selectedColor: colorForAllergen(allergen, theme),
          showCheckmark: false,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      );
    }

    // 並び順を日本語ラベルで整える
    final mandatory = [...mandatoryAllergens]..sort(compareByLabel);
    final recommended = [...recommendedAllergens]..sort(compareByLabel);
    final selected = appState.selectedAllergens.toList()..sort(compareByLabel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          TextButton(
            onPressed: () async => appState.clearAllergens(),
            child: const Text(
              'クリア',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          buildSectionHeader('アレルゲン（義務表示 8品目）'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              children: mandatory.map(buildAllergenChip).toList(),
            ),
          ),
          buildSectionHeader('アレルゲン（推奨表示 20品目）'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              children: recommended.map(buildAllergenChip).toList(),
            ),
          ),
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
                          onDeleted: () async =>
                              appState.setAllergenSelected(a, false),
                        ),
                      ),
                    )
                    .toList(),
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
