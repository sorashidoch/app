import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/services/app_state.dart';

/// 料理名の設定画面：追加・一覧・削除（完了/戻る対応）
class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key, this.returnTo});

  // 戻り先（指定があればそこへ、なければ /profile）
  final String? returnTo;

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final TextEditingController _menuController = TextEditingController();
  late List<String> _tempMenus;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _tempMenus = List<String>.from(appState.rouletteMenus);
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  void _addMenu(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    final exists =
        _tempMenus.any((m) => m.toLowerCase() == trimmed.toLowerCase());
    if (exists) return;
    setState(() {
      _tempMenus.add(trimmed);
      _menuController.clear();
    });
  }

  void _removeMenu(String value) {
    setState(() {
      _tempMenus.remove(value);
    });
  }

  String get _returnPath => widget.returnTo ?? '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('料理名の設定'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('ルーレットの料理名'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _menuController,
                    maxLength: 20, // 最大20文字
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20), // 入力自体を20文字に制限
                    ],
                    decoration: const InputDecoration(
                      hintText: '例：ラーメン',
                      labelText: '料理名を追加',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _addMenu,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addMenu(_menuController.text),
                  child: const Text('追加'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              children: _tempMenus
                  .map(
                    (m) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      child: InputChip(
                        label: Text(m),
                        onDeleted: () => _removeMenu(m),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (_tempMenus.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('料理名が未登録です'),
            ),
          const SizedBox(height: 24),
        ],
      ),
      // 下部の操作ボタン（戻る / 完了）
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
                    // 変更を破棄して戻る
                    context.go(_returnPath);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('完了'),
                  onPressed: () async {
                    // 変更を保存して戻る
                    final appState = context.read<AppState>();
                    await appState.setRouletteMenus(_tempMenus);
                    if (mounted) {
                      context.go(_returnPath);
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
