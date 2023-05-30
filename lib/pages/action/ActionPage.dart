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
  static const list = <Map>[
    { "icon": CupertinoIcons.add, "label": 'Nguyên vật liệu', "color": Color(0xFFDB685B), "path": '/' },
    { "icon": CupertinoIcons.add, "label": 'Loại cây trồng', "color": Color(0xFFDDAA33), "path": '/' },
    { "icon": CupertinoIcons.add, "label": 'Công việc - Tình trạng', "color": Color(0xFF44803F), "path": '/' },
    { "icon": CupertinoIcons.bolt_circle, "label": 'Tra cứu', "color": Color(0xFF146152), "path": '/' },
    { "icon": CupertinoIcons.add, "label": 'Đất - Cơ sở', "color": Color(0xff284F8F), "path": '/' },
    { "icon": CupertinoIcons.add, "label": 'Thiết bị - Máy móc', "color": Color(0xff592F64), "path": '/' }
  ];

  @override
  Widget build(BuildContext context) {
    // return Container();
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
          itemCount: list.length,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 1/1,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: list[index]['color'],
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(list[index]['icon'], size: 30, color: Colors.white,),
                    SizedBox(height: 5,),
                    Text(list[index]['label'], style: const TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center,)
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