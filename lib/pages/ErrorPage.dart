import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends ConsumerWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Không tìm thấy trang hiện tại"),
            Consumer(builder: (context, ref, child) {
              return TextButton(onPressed: () {
                context.go('/');
              }, child: const Text("Về trang chủ"));
            },)
          ]
        ),
      ),
    );
  }
}