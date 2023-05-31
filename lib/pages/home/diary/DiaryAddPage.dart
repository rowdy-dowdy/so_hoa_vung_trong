import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DiaryAddPage extends ConsumerStatefulWidget {
  const DiaryAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryAddPageState();
}

class _DiaryAddPageState extends ConsumerState<DiaryAddPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm mới nhật ký sản xuất"),
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
    );
  }
}