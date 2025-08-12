import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/allergen.dart';
import '../../../shared/models/allergen_icons.dart';
import '../../../shared/services/app_state.dart';
import '../../../shared/widgets/common_header.dart';

/// アレルゲン設定画面：義務表示/推奨表示の選択UI + 選択中一覧（決定/戻る対応）
class AllergyScreen extends StatefulWidget {
  const AllergyScreen({super.key});

  @override
  State<AllergyScreen> createState() => _AllergyScreenState();
}

class _AllergyScreenState extends State<AllergyScreen> {
  // 画面内で一時的に保持する選択集合（「決定」でのみ反映）
  late Set<Allergen> _tempSelected;

  @override
  void initState() {
    super.initState();
    // Provider を listen: false で参照し、現在の選択状態をコピー
    final appState = Provider.of<AppState>(context, listen: false);
    _tempSelected = Set<Allergen>.from(appState.selectedAllergens);
  }

  // 見出しウィジェット（共通）
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  // トグルチップ（共通）
  Widget _buildAllergenChip(BuildContext context, Allergen allergen) {
    final theme = Theme.of(context);
    final isSelected = _tempSelected.contains(allergen);
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
        onSelected: (value) {
          setState(() {
            if (value) {
              _tempSelected.add(allergen);
            } else {
              _tempSelected.remove(allergen);
            }
          });
        },
        selectedColor: colorForAllergen(allergen, theme),
        showCheckmark: false,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 並び順を日本語ラベルで整える
    final mandatory = [...mandatoryAllergens]..sort(compareByLabel);
    final recommended = [...recommendedAllergens]..sort(compareByLabel);
    final selected = _tempSelected.toList()..sort(compareByLabel);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(title: 'アレルゲン設定'),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _tempSelected.clear();
                    });
                  },
                  child: const Text('クリア'),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSectionHeader(context, 'アレルゲン（義務表示 8品目）'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      children: mandatory
                          .map((a) => _buildAllergenChip(context, a))
                          .toList(),
                    ),
                  ),
                  _buildSectionHeader(context, 'アレルゲン（推奨表示 20品目）'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      children: recommended
                          .map((a) => _buildAllergenChip(context, a))
                          .toList(),
                    ),
                  ),
                  _buildSectionHeader(context, '選択中のアレルゲン'),
                  if (selected.isEmpty)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                  onDeleted: () {
                                    setState(() {
                                      _tempSelected.remove(a);
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      // 下部の操作ボタン（戻る / 決定）
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('戻る'),
                  onPressed: () {
                    // 変更は破棄される（未確定のため）
                    context.go('/profile');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('決定'),
                  onPressed: () async {
                    // 確定してアプリ状態に反映
                    final appState = context.read<AppState>();
                    await appState.setSelectedAllergens(_tempSelected);
                    // プロフィールに戻る
                    if (mounted) {
                      context.go('/profile');
                    }
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
