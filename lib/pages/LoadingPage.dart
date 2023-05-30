import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: primary,
        child: Center(
          child: SizedBox(
            width: 300,
            child: Lottie.asset(
              'assets/lotties/loading_lotties.json',
            ),
          ),
        ),
      ),
    );
  }
}