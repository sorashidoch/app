import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/text_styles.dart';
import '../../../shared/services/app_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String _formatDateTime(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}/${two(dt.month)}/${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final history = appState.rouletteHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('履歴'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          TextButton.icon(
            onPressed: history.isEmpty
                ? null
                : () async {
                    await appState.clearRouletteHistory();
                  },
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            label: const Text('クリア', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(item.menu, style: AppTextStyles.body),
            subtitle: Text(_formatDateTime(item.dateTime),
                style: AppTextStyles.caption),
          );
        },
      ),
    );
  }
}
