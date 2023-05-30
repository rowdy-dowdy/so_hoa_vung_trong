import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DiaryEditPage extends ConsumerStatefulWidget {
  final String id;
  const DiaryEditPage({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryEditStatePage();
}

class _DiaryEditStatePage extends ConsumerState<DiaryEditPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa nhật ký sản xuất"),
        leading: IconButton(
          onPressed: () => context.go('/diary/${widget.id}'),
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
    );
  }
}