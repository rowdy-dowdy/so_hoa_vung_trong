import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';

class ExpertPage extends ConsumerStatefulWidget {
  const ExpertPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpertPageState();
}

class _ExpertPageState extends ConsumerState<ExpertPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Text("data"),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}