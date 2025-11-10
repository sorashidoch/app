import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/text_styles.dart';
import '../../../shared/services/app_state.dart';
import '../../../shared/widgets/common_header.dart';

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
    final favMemos = appState.favoriteMemos;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const CommonHeader(title: '履歴'),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: history.isEmpty
                    ? null
                    : () async {
                        await appState.clearRouletteHistory();
                      },
                icon: const Icon(Icons.delete_outline),
                label: const Text('クリア'),
              ),
            ),
            // お気に入りメモセクション
            const Text('お気に入りメモ', style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            if (favMemos.isEmpty)
              const Text('お気に入り登録されたメモはありません', style: AppTextStyles.caption)
            else
              ...favMemos.map((m) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: Text(m.title, style: AppTextStyles.body),
                      isThreeLine: true,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // メモ内容を複数行表示し、URLは自動リンク化して外部ブラウザで開く
                          Container(
                            constraints: const BoxConstraints(maxHeight: 40),
                            child: SelectableLinkify(
                              text: m.content,
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.black87,
                              ),
                              options: const LinkifyOptions(
                                humanize: true,
                                looseUrl: true,
                              ),
                              onOpen: (link) async {
                                var url = link.url;
                                if (!url.startsWith('http://') &&
                                    !url.startsWith('https://')) {
                                  url = 'https://$url';
                                }
                                final uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  final success = await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                  if (!success) {
                                    // ここではScaffoldMessengerが使いづらいので静かに失敗
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '作成: ${_formatDateTime(m.memoDateTime)}',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  )),
            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 24),
            // ルーレット履歴セクション
            const Text('ルーレット履歴', style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            if (history.isEmpty)
              const Text('ルーレットの履歴はありません', style: AppTextStyles.caption)
            else
              ...List.generate(history.length, (index) {
                final item = history[index];
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(item.menu, style: AppTextStyles.body),
                      subtitle: Text(_formatDateTime(item.dateTime),
                          style: AppTextStyles.caption),
                    ),
                    const Divider(height: 1),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }
}
