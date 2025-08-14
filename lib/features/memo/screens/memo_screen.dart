import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/models/memo_favorite.dart';
import '../../../shared/services/app_state.dart';
import '../../../shared/widgets/button_with_icon.dart';
import '../../../shared/widgets/common_header.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  final List<MemoItem> _memos = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isAddingMemo = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _addMemo() {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      setState(() {
        _memos.add(MemoItem(
          title: _titleController.text,
          content: _contentController.text,
          timestamp: DateTime.now(),
        ));
        _titleController.clear();
        _contentController.clear();
        _isAddingMemo = false;
      });
    }
  }

  void _deleteMemo(int index) {
    setState(() {
      _memos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 共通ヘッダー
              const CommonHeader(title: 'メモ帳'),

              // メインコンテンツ
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // メモ追加ボタン（リスト領域の上部に配置）
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _isAddingMemo = true;
                              });
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('メモを追加'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // メモ追加フォーム
                        if (_isAddingMemo)
                          ButtonWithIcon(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '新しいメモ',
                                    style: AppTextStyles.heading2.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                      labelText: 'タイトル',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _contentController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      labelText: '内容',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: _addMemo,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const Text(
                                            '保存',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _isAddingMemo = false;
                                              _titleController.clear();
                                              _contentController.clear();
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const Text(
                                            'キャンセル',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        if (_isAddingMemo) const SizedBox(height: 16),

                        // メモ一覧
                        Expanded(
                          child: _memos.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.note,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'メモがありません',
                                        style: AppTextStyles.body.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '＋ボタンを押してメモを追加しましょう！',
                                        style: AppTextStyles.caption.copyWith(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _memos.length,
                                  itemBuilder: (context, index) {
                                    final memo = _memos[index];
                                    final favoriteItem = FavoriteMemoItem(
                                      title: memo.title,
                                      content: memo.content,
                                      memoDateTime: memo.timestamp,
                                    );
                                    final isFav =
                                        appState.isFavoriteMemo(favoriteItem);
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: ButtonWithIcon(
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      memo.title,
                                                      style: AppTextStyles
                                                          .heading3
                                                          .copyWith(
                                                        fontSize: 16,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () => appState
                                                        .toggleFavoriteMemo(
                                                            favoriteItem),
                                                    icon: Icon(
                                                      isFav
                                                          ? Icons.star
                                                          : Icons.star_border,
                                                      color: isFav
                                                          ? Colors.amber
                                                          : Colors.grey,
                                                      size: 22,
                                                    ),
                                                    tooltip: isFav
                                                        ? 'お気に入りを外す'
                                                        : 'お気に入りに追加',
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        _deleteMemo(index),
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              // 内容のURLを自動検出してタップで外部ブラウザを起動する
                                              SelectableLinkify(
                                                text: memo.content,
                                                style: AppTextStyles.body,
                                                options: const LinkifyOptions(
                                                  humanize: true,
                                                  looseUrl: true,
                                                ),
                                                onOpen: (link) async {
                                                  // http/https がない場合は https を補完して起動する
                                                  var url = link.url;
                                                  if (!url.startsWith(
                                                          'http://') &&
                                                      !url.startsWith(
                                                          'https://')) {
                                                    url = 'https://$url';
                                                  }
                                                  final uri = Uri.parse(url);
                                                  if (await canLaunchUrl(uri)) {
                                                    final success =
                                                        await launchUrl(
                                                      uri,
                                                      mode: LaunchMode
                                                          .externalApplication,
                                                    );
                                                    if (!success && mounted) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'URLを開けませんでした'),
                                                        ),
                                                      );
                                                    }
                                                  } else if (mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'URLを開けませんでした'),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '${memo.timestamp.year}/${memo.timestamp.month.toString().padLeft(2, '0')}/${memo.timestamp.day.toString().padLeft(2, '0')} ${memo.timestamp.hour.toString().padLeft(2, '0')}:${memo.timestamp.minute.toString().padLeft(2, '0')}',
                                                style: AppTextStyles.caption
                                                    .copyWith(
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MemoItem {
  MemoItem({
    required this.title,
    required this.content,
    required this.timestamp,
  });
  final String title;
  final String content;
  final DateTime timestamp;
}
