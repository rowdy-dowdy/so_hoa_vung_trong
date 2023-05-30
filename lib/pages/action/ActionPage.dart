import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class ActionPage extends ConsumerStatefulWidget {
  const ActionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActionPageState();
}

class _ActionPageState extends ConsumerState<ActionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh mục"),
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: AlignedGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          itemCount: 6,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 1/1,
              child: Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.bolt_circle, size: 30, color: Colors.white,),
                    SizedBox(height: 5,),
                    Text("Tra cứu", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ],
                ),
              ),
            );
          },
        )
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}